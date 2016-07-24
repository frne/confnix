pkgs:
let
  callPackage = pkgs.lib.callPackageWith(custom // pkgs);
  custom = {
    blueimpGallery = callPackage ./blueimp-gallery {};
    blueimpImageGallery = callPackage ./blueimp-image-gallery {};
    c544ppd = callPackage ./lexmark-c544 {};
    cask = callPackage ./cask {};
    cdparanoiax = callPackage ./cdparanoiax {};
    clojuredocs = callPackage ./clojure-docs {};
    conkeror = callPackage ./conkeror {};
    coursier = callPackage ./coursier {};
    derby = callPackage ./derby {};
    drip = callPackage ./drip {};
    ejabberd15 = callPackage ./ejabberd {};
    elexis = callPackage ./elexis {};
    exim = callPackage ./exim {};
    freerdpUnstable = callPackage ./freerdp {};
    gitblit = callPackage ./gitblit {};
    handlebars = callPackage ./handlebars {};
    hinclient = callPackage ./hinclient {};
    hl5380ppd = callPackage ./brother-hl5380 {};
    html2textpy = callPackage ./html2textpy {};
    javadocs = callPackage ./java-docs {};
    jquery2 = callPackage ./jquery2 {};
    kube = callPackage ./kube {};
    lsdvd = callPackage ./lsdvd {};
    markdown = callPackage ./markdown {};
    mediathekview = callPackage ./mediathekview {};
    mongodex = callPackage ./dex {};
    msgconvert = callPackage ./msgconvert {};
    neo2osd = callPackage ./neo2osd {};
    neomodmap = callPackage ./neomodmap {};
    nginx =  callPackage ./nginx {};
    odt2org = callPackage ./odt2org {};
    pam_script = callPackage ./pam-script {};
    publet = callPackage ./publet {};
    publetQuartz = callPackage ./publet/quartz.nix {};
    publetSharry = callPackage ./publet/sharry.nix {};
    recutils = callPackage ./recutils {};
    roundcube = callPackage ./roundcube {};
    scaladocs = callPackage ./scala-docs {};
    shelter = callPackage ./shelter {};
    sig = callPackage ./sig {};
    sitebag = callPackage ./sitebag {};
    soundkonverter = callPackage ./soundkonverter {};
    spark = callPackage ./spark {};
    storeBackup = callPackage ./storebackup {};
    stumpwmdocs = callPackage ./stumpwm/docs.nix {};
    tesseract304 = callPackage ./tesseract {};
    twitterBootstrap3 = callPackage ./twbs {};
    visualvm = callPackage ./visualvm {};
#    flashplayer = callPackage ./flashplayer {};
#    makemkv = callPackage ./makemkv {};
#    stumpwm = callPackage ./stumpwm {};
  };
  osxcollection = import ./osxcollection/default.nix (custom // pkgs);
in custom // { inherit osxcollection; }
