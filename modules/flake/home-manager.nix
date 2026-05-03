{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.flake.homeModules = mkOption {
    type = types.attrsOf types.deferredModule;
    default = {};
    description = "Exported home-manager modules";
  };
}
