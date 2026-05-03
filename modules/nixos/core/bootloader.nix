{
  flake.nixosModules.bootloader = {
    lib,
    pkgs,
    ...
  }: {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        configurationLimit = lib.mkDefault 5;
        device = lib.mkDefault "nodev";
        efiSupport = true;
        useOSProber = true;
        theme = pkgs.minimal-grub-theme;
      };
    };
  };
}
