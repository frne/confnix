pkgs:
let
  callPackage = pkgs.lib.callPackageWith(custom // pkgs);
  custom = {
    blueimpGallery = callPackage ./blueimp-gallery {};
    blueimpImageGallery = callPackage ./blueimp-image-gallery {};
    c544ppd = callPackage ./lexmark-c544 {};
    cdparanoiax = callPackage ./cdparanoiax {};
    clojuredocs = callPackage ./clojure-docs {};
    conkeror = callPackage ./conkeror {};
    derby = callPackage ./derby {};
    drip = callPackage ./drip {};
    ejabberd15 = callPackage ./ejabberd {};
    exim = callPackage ./exim {};
    flashplayer = callPackage ./flashplayer {};
    gitblit = callPackage ./gitblit {};
    handlebars = callPackage ./handlebars {};
    html2textpy = callPackage ./html2textpy {};
    javadocs = callPackage ./java-docs {};
    jquery2 = callPackage ./jquery2 {};
    kube = callPackage ./kube {};
    lsdvd = callPackage ./lsdvd {};
    markdown = callPackage ./markdown {};
    mediathekview = callPackage ./mediathekview {};
    neo2osd = callPackage ./neo2osd {};
    nginx = callPackage ./nginx {};
    publet = callPackage ./publet {};
    publetSharry = callPackage ./publet/sharry.nix {};
    publetQuartz = callPackage ./publet/quartz.nix {};
    roundcube = callPackage ./roundcube {};
    scaladocs = callPackage ./scala-docs {};
    shelter = callPackage ./shelter {};
    sig = callPackage ./sig {};
    sitebag = callPackage ./sitebag {};
    soundkonverter = callPackage ./soundkonverter {};
    storeBackup = callPackage ./storebackup {};
    stumpwm = callPackage ./stumpwm {};
    stumpwmdocs = callPackage ./stumpwm/docs.nix {};
    texLiveModerntimeline = with pkgs; builderDefsPackage (import ./moderntimelinefix) {
      inherit texLive unzip;
    };
    twitterBootstrap3 = callPackage ./twbs {};
    visualvm = callPackage ./visualvm {};
  };

in custom
