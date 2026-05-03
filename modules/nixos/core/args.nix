{withSystem, ...}: {
  flake.nixosModules.core = {pkgs, ...}: let
    withSystem' = withSystem pkgs.stdenv.hostPlatform.system;
  in {
    _module.args = {
      inherit withSystem';
      self' = withSystem' ({self', ...}: self');
      inputs' = withSystem' ({inputs', ...}: inputs');
    };
  };
}
