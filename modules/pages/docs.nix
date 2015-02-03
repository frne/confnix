# a list of documentation pages for scala, java and clojure
# use it like this in your configuration.nix:
#
#  services.pages = import docs.nix pkgs;
#
pkgs:
{
  enable = true;
  sources = [
  { name = "Scala 2.11.5 Library Docs";
    location = "scalalib";
    root = "${pkgs.scaladocs}/api/scala-library/";}
  { name = "Scala 2.11.5 Compiler Docs";
    location = "scalacompiler";
    root = "${pkgs.scaladocs}/api/scala-compiler/"; }
  { name = "Java Docs 8";
    location = "javadocs8";
    root = "${pkgs.javadocs.jdk8}/api/";}
  { name = "Java Docs 7";
    location = "javadocs7";
    root = "${pkgs.javadocs.jdk7}/api/";}
  { name = "Clojure 1.6 Api Docs";
    location = "clojure16";
    root = "${pkgs.clojuredocs}/"; }
  { name = "Stumpwm 0.9.9 Manual";
    location = "stumpwm";
    root = "${pkgs.stumpwmdocs}/"; }];
}
