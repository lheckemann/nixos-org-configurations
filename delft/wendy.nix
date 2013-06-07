{ config, pkgs, ... }:
with pkgs.lib;
let
  myIP = "130.161.158.181";
  machines = import ./machines.nix pkgs.lib;

in
{
  require = [ ./build-machines-dell-r815.nix ./delft-webserver.nix ];

  fileSystems."/backup" =
    { device = "130.161.158.5:/dxs/users4/group/buildfarm";
      fsType = "nfs4";
    };

  jobs.mturk_webserver_production =
    { name = "mturk-webserver-production";
      startOn = "started network-interfaces";
      exec = ''
        ${pkgs.su}/bin/su - mturk -c 'MTURK_STATE=/home/mturk/state-production WEBINTERFACE_HOME=/home/mturk/icse-2012/src/WebInterface WEBINTERFACE_CONFIG=/home/mturk/icse-2012/src/WebInterface/webinterface-production.conf exec /home/mturk/icse-2012/src/WebInterface/script/webinterface_server.pl -f -k >> /home/mturk/state-production/webserver.log 2>&1'
      '';
    };

  jobs.mturk_webserver_sandbox =
    { name = "mturk-webserver-sandbox";
      startOn = "started network-interfaces";
      exec = ''
        ${pkgs.su}/bin/su - mturk -c 'WEBINTERFACE_HOME=/home/mturk/icse-2012/src/WebInterface WEBINTERFACE_CONFIG=/home/mturk/icse-2012/src/WebInterface/webinterface-sandbox.conf exec /home/mturk/icse-2012/src/WebInterface/script/webinterface_server.pl -p 3001 -f -k >> /home/mturk/state-sandbox/webserver.log 2>&1'
      '';
    };

  jobs.mturk_vnc_multiplexer_production =
    { name = "mturk-vnc-multiplexer-production";
      startOn = "started network-interfaces";
      exec = ''
        ${pkgs.su}/bin/su - mturk -c 'MTURK_STATE=/home/mturk/state-production exec vnc-multiplexer.pl >> /home/mturk/state-production/multiplexer.log 2>&1'
      '';
    };

  jobs.mturk_vnc_multiplexer_sandbox =
    { name = "mturk-vnc-multiplexer-sandbox";
      startOn = "started network-interfaces";
      exec = ''
        ${pkgs.su}/bin/su - mturk -c 'exec vnc-multiplexer.pl >> /home/mturk/state-sandbox/multiplexer.log 2>&1'
      '';
    };

  /*
  jobs.mturk_hydra_bridge_production =
    { name = "mturk-hydra-bridge-production";
      exec = ''
        ${pkgs.su}/bin/su - mturk -c 'MTURK_STATE=/home/mturk/state-production exec create-hits-from-hydra.pl >> /home/mturk/state-production/hydra-bridge.log 2>&1'
      '';
    };
  */

  jobs.mturk_vm_cleanup_production =
    { name = "mturk-vm-cleanup-production";
      exec = ''
        ${pkgs.su}/bin/su - mturk -c 'export MTURK_STATE=/home/mturk/state-production; while true; do cleanup-vms.pl >> /home/mturk/state-production/cleanup-vms.log 2>&1; sleep 60; done'
      '';
    };

  services.postgresqlBackup = {
    enable = true;
    databases = [ "hydra" "jira" ];
  };

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    package = pkgs.postgresql92;
    dataDir = "/data/postgresql";
    extraConfig = ''
      log_min_duration_statement = 1000
      log_duration = off
      log_statement = 'none'
      max_connections = 250
      work_mem = 16MB
      shared_buffers = 4GB
      # Checkpoint every 256 MB.
      checkpoint_segments = 16
      # We can risk losing some transactions.
      synchronous_commit = off
    '';
    authentication = ''
      host  all        all       192.168.1.25/32 md5
      host  hydra      hydra     192.168.1.26/32 md5
      host  hydra_test hydra     192.168.1.26/32 md5
      host  zabbix     zabbix    192.168.1.5/32  md5
    '';
  };

  # Bump kernel.shmmax for PostgreSQL. FIXME: this should be a NixOS
  # option around systemd-sysctl.
  system.activationScripts.setShmMax =
    ''
      ${pkgs.procps}/sbin/sysctl -q -w kernel.shmmax=$((6 * 1024**3))
    '';

  services.zabbixAgent.extraConfig = ''
    UserParameter=hydra.queue.total,${pkgs.postgresql}/bin/psql hydra -At -c 'select count(*) from builds where finished = 0'
    UserParameter=hydra.queue.building,${pkgs.postgresql}/bin/psql hydra -At -c 'select count(*) from builds where finished = 0 and busy = 1'
    UserParameter=hydra.queue.buildsteps,${pkgs.postgresql}/bin/psql hydra -At -c 'select count(*) from BuildSteps s join Builds i on s.build = i.id where i.finished = 0 and i.busy = 1 and s.busy = 1'
    UserParameter=hydra.builds,${pkgs.postgresql}/bin/psql hydra -At -c 'select count(*) from Builds'
  '';

  services.cron.systemCronJobs =
    [ "15 4 * * * root cp -v /var/backup/postgresql/* /backup/wendy/postgresql/  &> /var/log/backup-db.log"
    ];

  services.udev.extraRules =
    ''
      ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="f0:4d:a2:40:1b:be", NAME="external"
      ACTION=="add", SUBSYSTEM=="net", ATTR{address}=="f0:4d:a2:40:1b:c0", NAME="internal"
    '';


  networking = {
    hostName = "wendy";
    domain = "buildfarm";

    interfaces.external =
      { ipAddress = myIP;
        prefixLength = 23;
      };

    interfaces.internal =
      { ipAddress = (findSingle (m: m.hostName == "wendy") {} {} machines).ipAddress;
        prefixLength = 22;
      };

    useDHCP = false;

    defaultGateway = "130.161.158.1";

    nameservers = [ "127.0.0.1" ];

    extraHosts = "192.168.1.26 wendy";

    firewall.allowedTCPPorts = [ 80 443 843 10051 5999 ];
    firewall.allowedUDPPorts = [ 53 67 ];
    firewall.extraCommands =
      ''
        ip46tables -I nixos-fw-accept -p tcp --dport 843 --syn -j LOG --log-level info --log-prefix "POLICY REQUEST: "
        ip46tables -A nixos-fw -p tcp --dport 5432 -s 192.168.1.25 -j nixos-fw-accept
      '';

    nat.enable = true;
    nat.internalIPs = "192.168.1.0/22";
    nat.externalInterface = "external";
    nat.externalIP = myIP;


  };

  jobs.dnsmasq =
    let

      confFile = pkgs.writeText "dnsmasq.conf"
        ''
          keep-in-foreground
          no-hosts
          addn-hosts=${hostsFile}
          expand-hosts
          domain=buildfarm
          interface=internal

          server=130.161.158.4
          server=130.161.33.17
          server=130.161.180.1
          server=8.8.8.8
          server=8.8.4.4

          dhcp-range=192.168.1.150,192.168.3.200

          ${flip concatMapStrings machines (m: optionalString (m ? ethernetAddress) ''
            dhcp-host=${m.ethernetAddress},${m.ipAddress},${m.hostName}
          '')}
        '';

      hostsFile = pkgs.writeText "extra-hosts"
        (flip concatMapStrings machines (m: "${m.ipAddress} ${m.hostName}\n"));

    in
    { startOn = "started network-interfaces";
      exec = "${pkgs.dnsmasq}/bin/dnsmasq --conf-file=${confFile}";
    };

  # Needed for the Nixpkgs mirror script.
  environment.pathsToLink = [ "/libexec" ];
  environment.systemPackages = [ pkgs.dnsmasq pkgs.duplicity ];

  # Use cgroups to limit Apache's resources.
  systemd.services.httpd.serviceConfig.CPUShares = 1000;
  systemd.services.httpd.serviceConfig.MemoryLimit = "1500M";
  systemd.services.httpd.serviceConfig.ControlGroupAttribute = [ "memory.memsw.limit_in_bytes 1500M" ];
}
