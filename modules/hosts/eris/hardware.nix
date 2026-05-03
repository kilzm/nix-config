_: {
  flake.nixosModules.eris = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [(modulesPath + "/installer/scan/not-detected.nix")];

    boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "ahci" "usbhid" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-amd"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/c51948cf-e4de-42fd-b2ff-2b322bbf5859";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/DA84-64F6";
      fsType = "vfat";
    };

    fileSystems."/mnt/wdb2tb" = {
      device = "/dev/disk/by-uuid/1AE09F4DE09F2DCF";
      fsType = "ntfs";
    };

    fileSystems."/mnt/wdb1tb" = {
      device = "/dev/disk/by-uuid/F85CFB735CFB2AD0";
      fsType = "ntfs";
    };

    swapDevices = [];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
