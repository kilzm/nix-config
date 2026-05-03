{ pkgs }:
let
  inherit (pkgs) callPackage;
in
{
  gdb-frontend = callPackage ./gdb-frontend { };
  google-sans-flex = callPackage ./google-sans-flex { };
}
