{self, ...}: {
  flake.nixosModules.sedna = {pkgs, ...}: {
    imports = with self.nixosModules; [
      core
      desktop
      power
      virtualisation
    ];

    boot = {
      loader.grub.configurationLimit = 2;
      kernelPackages = pkgs.linuxPackages_latest;
      kernelParams = ["video=eDP-1:2160x1440@60"];
      kernelModules = ["i2c-dev" "i2cpiix4"];
      initrd.kernelModules = ["i915"];
      supportedFilesystems.ntfs = true;
    };

    hardware.graphics = {
      extraPackages = with pkgs; [intel-media-driver];
      extraPackages32 = with pkgs.pkgsi686Linux; [intel-media-driver];
    };
    environment.sessionVariables = {
      LIBVA_DRIVER_NAME = "iHD";
    };

    networking.hostName = "sedna";

    system.stateVersion = "26.05";
  };
}
