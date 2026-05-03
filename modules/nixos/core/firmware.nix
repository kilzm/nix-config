{
  flake.nixosModules.firmware = {
    hardware.enableAllFirmware = true;
  };
}
