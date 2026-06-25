{
  flake.nixosModules.usb = {
    services.udisks2 = {
      enable = true;
    };
  };
}
