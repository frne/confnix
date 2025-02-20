# a list of documentation pages for scala, java and clojure
# use it like this in your configuration.nix:
#
#  services.pages.sources = import docs.nix pkgs;
#
pkgs:
[
  { name = "Scala 2.11.7 Library Docs";
    location = "scalalib";
    root = "${pkgs.scaladocs}/api/scala-library/";}
  { name = "Scala 2.11.7 Compiler Docs";
    location = "scalacompiler";
    root = "${pkgs.scaladocs}/api/scala-compiler/"; }
  { name = "Java 8 Api Docs";
    location = "javadocs8";
    root = "${pkgs.javadocs.jdk8}/api/";}
  { name = "Java 9 Api Docs";
    location = "javadocs9";
    root = "${pkgs.javadocs.jdk9}/api/";}
  { name = "Clojure 1.7 Api Docs";
    location = "clojure17";
    root = "${pkgs.clojuredocs}/"; }
  { name = "Stumpwm 0.9.9 Manual";
    location = "stumpwm";
    root = "${pkgs.stumpwmdocs}/"; }
  # { name = "Orgmode Manual";
  #   location = "orgmode";
  #   root = "${pkgs.emacs24Packages.org}/share/doc/${pkgs.emacs24Packages.org.name}/";
  #   file = "org.html"; }
]
