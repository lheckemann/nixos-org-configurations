attrs :

# check jobs-helpers.nix for documentation.
with (import ./jobs-helpers.nix) attrs;

{

  javaFrontSyntaxTrunk = makeEasyJob {
    spec = specs.javaFrontSyntax;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  javaFrontTrunk = makeEasyJob {
    spec = specs.javaFront;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  prologToolsTrunk = makeEasyJob {
    spec = specs.prologTools;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  asterTrunk = makeEasyJob {
    spec = specs.aster;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  aspectjFrontSyntaxTrunk = makeEasyJob {
    spec = specs.aspectjFrontSyntax;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  aspectjFrontTrunk = makeEasyJob {
    spec = specs.aspectjFront;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  jimpleFrontTrunk = makeEasyJob {
    spec = specs.jimpleFront;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  phpFrontTrunk = makeEasyJob {
    spec = specs.phpFront;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  sqlFrontTrunk = makeEasyJob {
    spec = specs.sqlFront;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  dryadTrunk = makeEasyJob {
    spec = specs.dryad;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  dryadCompilerTrunk = makeEasyJob {
    spec = specs.dryadCompiler;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  transformersGenericToolsTrunk = makeEasyJob {
    spec = specs.transformersGenericTools;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  transformersCToolsTrunk = makeEasyJob {
    spec = specs.transformersCTools;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  transformersCxxToolsTrunk = makeEasyJob {
    spec = specs.transformersCxxTools;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  lutinTrunk = makeEasyJob {
    spec = specs.lutin;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  magnoliaTrunk = makeEasyJob {
    spec = specs.magnolia;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  strategoxtUtilsTrunk = makeEasyJob {
    spec = specs.strategoxtUtils;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  strategoLibrariesTrunk = makeEasyJob {
    spec = specs.strategoLibraries;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  strategoShellTrunk = makeEasyJob {
    spec = specs.strategoShell;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  xdocTrunk = makeEasyJob {
    spec = specs.xdoc;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  webdslTrunk = makeEasyJob {
    spec = specs.webdsl;
    makeInfoURL = makeInfoURL.usingBaseline;
  };

  /**
   * Stratego/XT 0.17
   */
  atermForStrategoXT017 = makeJob {
    args = 
      strategoxtArgs {
        jobFile = "strategoxt/releases.nix";
        jobAttr = "atermForStrategoXT017";
        subdir  = "strategoxt-0.17/aterm";
      };

    inputs = {
      systems = pathInput ./systems.nix;
      atermCheckout = svnInputRev svn+ssh://svn.cwi.nl/aterm/branches/64-bit-fixes 21238;
      metaBuildEnvInfo = urlInput http://releases.strategoxt.org/meta-build-env/meta-build-env-0.1pre24995-50nbjf4z/release-info.xml;
    };

    notifyAddresses = ["karltk@strategoxt.org" "martin.bravenboer@gmail.com" "e.visser@tudelft.nl"];
  };

  sdf2BundleForStrategoXT017 = makeJob {
    args = 
      strategoxtArgs {
        jobFile = "strategoxt/releases.nix";
        jobAttr = "sdf2BundleForStrategoXT017";
        subdir  = "strategoxt-0.17/sdf2-bundle";
      };

    inputs = {
      systems = pathInput ./systems.nix;
      atermInfo = urlInput http://releases.strategoxt.org/strategoxt-0.17/aterm/unstable/release-info.xml;
      ascSupportInfo = urlInput http://buildfarm.st.ewi.tudelft.nl/releases/meta-environment/asc-support-2.3pre21097-w8slj5v8/release-info.xml;
      asfSupportInfo = urlInput http://buildfarm.st.ewi.tudelft.nl/releases/meta-environment/asf-support-1.5pre19781-0a9vk2m6/release-info.xml;
      errorSupportInfo = urlInput http://buildfarm.st.ewi.tudelft.nl/releases/meta-environment/error-support-1.4pre21542-5kanxhfi/release-info.xml;
      pgenInfo = urlInput http://buildfarm.st.ewi.tudelft.nl/releases/meta-environment/pgen-2.4pre21317-2jbx7pvy/release-info.xml;
      ptSupportInfo =  urlInput http://buildfarm.st.ewi.tudelft.nl/releases/meta-environment/pt-support-2.1pre21423-27y7bn5c/release-info.xml;
      sdfLibraryInfo = urlInput http://buildfarm.st.ewi.tudelft.nl/releases/meta-environment/sdf-library-1.0pre21293-q0kr017v/release-info.xml;
      sdfSupportInfo = urlInput http://buildfarm.st.ewi.tudelft.nl/releases/meta-environment/sdf-support-2.3pre21547-2mylics2/release-info.xml;
      sglrInfo = urlInput http://buildfarm.st.ewi.tudelft.nl/releases/meta-environment/sglr-3.16pre20932-xh8w2ikz/release-info.xml;
      tideSupportInfo = urlInput http://buildfarm.st.ewi.tudelft.nl/releases/meta-environment/tide-support-1.2pre21550-yvkk4q8g/release-info.xml;
      toolbuslibInfo = urlInput http://buildfarm.st.ewi.tudelft.nl/releases/meta-environment/toolbuslib-0.9pre21552-w4kgsm0p/release-info.xml;
    };

    notifyAddresses = ["karltk@strategoxt.org" "martin.bravenboer@gmail.com" "e.visser@tudelft.nl"];
  };

  /**
   * Meta-Environment
   */
  metaBuildEnvTrunk = makeEasyJob {
    spec = specs.metaBuildEnv;
  };

  atermTrunk = makeEasyJob {
    spec = specs.aterm;
  };

  atermBranch64 = makeEasyJob {
    spec = specs.aterm;
    svn = "branch64";
    dirName = "aterm64";
  };

  sdfLibraryTrunk = makeEasyJob {
    spec = specs.sdfLibrary;
  };

  /* toolbuslibTrunk = makeEasyJob {
    spec = specs.toolbuslib;
  }; */

  toolbuslibTrunk64 = makeEasyJob {
    spec = specs.toolbuslib;
    dirName = "toolbuslib-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  cLibraryTrunk64 = makeEasyJob {
    spec = specs.cLibrary;
    dirName = "c-library-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  configSupportTrunk64 = makeEasyJob {
    spec = specs.configSupport;
    dirName = "config-support-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  errorSupportTrunk64 = makeEasyJob {
    spec = specs.errorSupport;
    dirName = "error-support-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  tideSupportTrunk64 = makeEasyJob {
    spec = specs.tideSupport;
    dirName = "tide-support-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  relationStoresTrunk64 = makeEasyJob {
    spec = specs.relationStores;
    dirName = "relation-stores-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  ptSupportTrunk64 = makeEasyJob {
    spec = specs.ptSupport;
    dirName = "pt-support-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  ptableSupportTrunk64 = makeEasyJob {
    spec = specs.ptableSupport;
    dirName = "ptable-support-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  sglrTrunk64 = makeEasyJob {
    spec = specs.sglr;
    dirName = "sglr-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  asfSupportTrunk64 = makeEasyJob {
    spec = specs.asfSupport;
    dirName = "asf-support-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  ascSupportTrunk64 = makeEasyJob {
    spec = specs.ascSupport;
    dirName = "asc-support-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  sdfSupportTrunk64 = makeEasyJob {
    spec = specs.sdfSupport;
    dirName = "sdf-support-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  pgenTrunk64 = makeEasyJob {
    spec = specs.pgen;
    dirName = "pgen-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  sdf2BundleTrunk64 = makeEasyJob {
    spec = specs.sdf2Bundle;
    dirName = "sdf2-bundle-with-aterm64";
    makeInfoURL = makeInfoURL.withATerm64;
  };

  /**
   * API documentation
   */
  strategoLibDocsTrunk = makeAPIJob {
    subdir = "libstratego-lib";
    jobAttr = "strategoLib";
    svn = https://svn.strategoxt.org/repos/StrategoXT/strategoxt/trunk/stratego-libraries/lib/spec;
  };

  strategoXTCDocsTrunk = makeAPIJob {
    subdir = "libstratego-xtc";
    jobAttr = "xtc";
    svn = https://svn.strategoxt.org/repos/StrategoXT/strategoxt/trunk/stratego-libraries/xtc/lib;
  };

  strategoSGLRDocsTrunk = makeAPIJob {
    subdir = "libstratego-sglr";
    jobAttr = "sglr";
    svn = https://svn.strategoxt.org/repos/StrategoXT/strategoxt/trunk/stratego-libraries/sglr/lib;
  };

  strategoGPPDocsTrunk = makeAPIJob {
    subdir = "libstratego-gpp";
    jobAttr = "gpp";
    svn = https://svn.strategoxt.org/repos/StrategoXT/strategoxt/trunk/stratego-libraries/gpp/lib;
  };

  strategoRTGDocsTrunk = makeAPIJob {
    subdir = "libstratego-rtg";
    jobAttr = "rtg";
    svn = https://svn.strategoxt.org/repos/StrategoXT/strategoxt/trunk/stratego-libraries/rtg/lib;
  };

  sdfLibrarySyntaxDocsTrunk = makeSyntaxJob {
    subdir = "sdf-library";
    jobAttr = "sdfLibrarySyntax";
    svn =svn+ssh://svn.cwi.nl/sdf-library/trunk/library ;
  };

  javaFrontSyntaxDocsTrunk = makeSyntaxJob {
    subdir = "java-front";
    jobAttr = "javaFrontSyntax";
    svn = https://svn.strategoxt.org/repos/StrategoXT/java-front/trunk/syntax/src;
  };

  jimpleFrontSyntaxDocsTrunk = makeSyntaxJob {
    subdir = "jimple-front";
    jobAttr = "jimpleFrontSyntax";
    svn = https://svn.strategoxt.org/repos/StrategoXT/sootxt/jimple-front/trunk/syn;
  };

  aspectjFrontSyntaxDocsTrunk = makeSyntaxJob {
    subdir = "aspectj-front";
    jobAttr = "aspectjFrontSyntax";
    svn = https://svn.strategoxt.org/repos/StrategoXT/aspectj-front/trunk/syntax/src;
    extraInputs = {
      javaFrontInfo = makeInfoURL.unstable specs.javaFront;
      aspectjFrontInfo = makeInfoURL.unstable specs.aspectjFront;
    };
  };

  dryadDocsTrunk = makeAPIJob {
    subdir = "libdryad";
    jobAttr = "dryadLibrary";
    svn = https://svn.strategoxt.org/repos/StrategoXT/dryad/trunk/lib;
    extraInputs = {
      javaFrontInfo = makeInfoURL.unstable specs.javaFront;
    };
  };

  phpFrontSyntaxDocsTrunk = makeSyntaxJob {
    subdir = "php-front";
    jobAttr = "phpFrontSyntax";
    svn = https://svn.strategoxt.org/repos/psat/php-front/trunk/src/grammar;
  };

  phpFrontLibraryDocsTrunk = makeAPIJob {
    subdir = "libphp-front";
    jobAttr = "phpFrontLibrary";
    svn = https://svn.strategoxt.org/repos/psat/php-front/trunk/src/lib;
  };

  /**
   * Complicated jobs
   */
  strategoxtTrunk = makeJob {
    args =
      strategoxtArgs {
        jobFile = "strategoxt/strategoxt.nix";
        jobAttr = "trunkRelease";
        subdir = "strategoxt";
      };

    inputs = {
      strategoxtCheckout = svnInput https://svn.strategoxt.org/repos/StrategoXT/strategoxt/trunk;
      systems = pathInput ./systems.nix;
      atermInfo = makeInfoURL.usingBaseline specs.aterm;
      sdf2BundleInfo = makeInfoURL.usingBaseline specs.sdf2Bundle;
      strategoxtBaselineTarball = urlInput baseline.strategoxtBootstrap;
    };

    notifyAddresses = ["karltk@strategoxt.org" "martin.bravenboer@gmail.com" "e.visser@tudelft.nl" "l.c.l.kats@tudelft.nl"];
  };

  strategoxtManualTrunk = makeJob {
    args = 
      strategoxtArgs {
        jobFile = "strategoxt/custom/manual.nix";
        jobAttr = "trunkRelease";
        subdir = "strategoxt-manual";
      };

    inputs = {
      strategoxtManualCheckout = svnInput https://svn.strategoxt.org/repos/StrategoXT/strategoxt-manual/trunk;
      systems = pathInput ./systems.nix;
      atermInfo = makeInfoURL.usingBaseline specs.aterm;
      sdf2BundleInfo = makeInfoURL.usingBaseline specs.sdf2Bundle;
      strategoxtInfo = makeInfoURL.usingBaseline specs.strategoxt;
    };

    notifyAddresses = ["karltk@strategoxt.org" "martin.bravenboer@gmail.com" "e.visser@tudelft.nl"];
  };

  strategoxtBasePackages = makeJob {
    args = 
      strategoxtArgs {
        jobFile = "strategoxt/custom/strategoxt-packages.nix";
        jobAttr = "baseRelease";
        subdir = "strategoxt-base-packages";
      };

    inputs = {
      systems = pathInput ./systems.nix;
      atermInfo = makeInfoURL.usingBaseline specs.aterm;
      sdf2BundleInfo = makeInfoURL.usingBaseline specs.sdf2Bundle;
      strategoxtInfo = makeInfoURL.unstable specs.strategoxt;
    };

    notifyAddresses = ["karltk@strategoxt.org" "martin.bravenboer@gmail.com" "e.visser@tudelft.nl"];
  };

  strategoxtPackages = makeJob {
    args = 
      strategoxtArgs {
        jobFile = "strategoxt/custom/strategoxt-packages.nix";
        jobAttr = "release";
        subdir = "strategoxt-packages";
      };

    inputs = {
      systems = pathInput ./systems.nix;
      atermInfo = makeInfoURL.usingBaseline specs.aterm;
      sdf2BundleInfo = makeInfoURL.usingBaseline specs.sdf2Bundle;
      strategoxtInfo = makeInfoURL.usingBaseline specs.strategoxt;
      strategoLibrariesInfo = makeInfoURL.usingBaseline specs.strategoLibraries;
      strategoxtUtilsInfo = makeInfoURL.unstable specs.strategoxtUtils;
      strategoShellInfo = makeInfoURL.unstable specs.strategoShell;
      javaFrontInfo = makeInfoURL.unstable specs.javaFront;
      dryadInfo = makeInfoURL.unstable specs.dryad;
      transformersGenericToolsInfo = makeInfoURL.unstable specs.transformersGenericTools;
      phpFrontInfo = makeInfoURL.unstable specs.phpFront;
    };

    notifyAddresses = ["karltk@strategoxt.org" "martin.bravenboer@gmail.com" "e.visser@tudelft.nl"];
  };


  strategoxtBootstrapBranch = makeJob {
    args =
      strategoxtArgs {
        jobFile = "strategoxt/strategoxt-ng.nix";
        jobAttr = "release";
        subdir = "strategoxt-bootstrap";
      };

    inputs = rec {
      strategoxtCheckout = svnInput (builtins.getAttr packagePath.string specs easy.fakePkgs).svn.trunk;
      systems = pathInput ./systems.nix;
      atermInfo = makeInfoURL.usingBaseline specs.aterm;
      sdf2BundleInfo = makeInfoURL.usingBaseline specs.sdf2Bundle;
      strategoxtBaselineTarball = urlInput baseline.strategoxtBootstrap;
      packagePath = {type = "string"; string = "strategoxtBootstrap";};
    };

    notifyAddresses = ["nicolas.b.pierron@gmail.com"];
  };


}


/*
  javaFrontSyntaxTrunk2 = makeStrategoXTJob {
    dirName = "java-front-syntax2";
    inputs = {
      javaFrontSyntaxCheckout = attrs.svnInput https://svn.strategoxt.org/repos/StrategoXT/java-front/trunk/syntax;
      atermInfo = easy.baseline.aterm;
      sdf2BundleInfo = easy.baseline.sdf;
      strategoxtInfo = easy.baseline.strategoxt;
    };

    notifyAddresses = ["martin.bravenboer@gmail.com"];
    jobAttr = "javaFrontSyntaxUnstable";
  };
*/