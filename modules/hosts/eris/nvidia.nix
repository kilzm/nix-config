{
  flake.nixosModules.eris = {
    config,
    lib,
    pkgs,
    ...
  }: {
    services.xserver.videoDrivers = lib.mkForce ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = false;
      };
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };

    hardware.amdgpu.initrd.enable = lib.mkForce false;

    hardware.graphics = {
      extraPackages = [pkgs.nvidia-vaapi-driver];
      extraPackages32 = [pkgs.pkgsi686Linux.nvidia-vaapi-driver];
    };

    home-manager.users.kilianm = {
      wayland.windowManager.hyprland.settings.env = [
        "LIBVA_DRIVER_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
    };
  };
}
