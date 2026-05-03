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
      kernelPackages = pkgs.linuxPackages_latest;
      # kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-zen4;
      kernelParams = ["amd_pstate=active" "mt7921e.disable_aspm=Y"];
      kernelModules = ["i2c-dev" "i2cpiix4"];
      supportedFilesystems.ntfs = true;
    };

    hardware.amdgpu.initrd.enable = true;

    networking.hostName = "eris";

    system.stateVersion = "26.05";
  };
}
