{
  flake.nixosModules.openrgb = {
    lib,
    pkgs,
    ...
  }: {
    hardware.i2c.enable = lib.mkDefault true;
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
    };
  };
}
