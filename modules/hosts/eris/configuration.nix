{self, ...}: {
  flake.nixosModules.eris = {pkgs, ...}: {
    imports = with self.nixosModules; [
      core
      desktop
      cachyos-kernel
      virtualisation
      openrgb
      gaming
    ];

    boot = {
      # kernelPackages = pkgs.linuxPackages_latest;
      kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;
      kernelParams = [
        "amd_pstate=active"
        "mt7921e.disable_aspm=Y"
        "video=DP-4:2560x1400@165"
      ];
      kernelModules = ["i2c-dev" "i2c-piix4"];
      supportedFilesystems.ntfs = true;
    };

    hardware.amdgpu.overdrive.enable = true;

    services.lact.enable = true;

    networking.hostName = "eris";

    system.stateVersion = "26.05";
  };
}
