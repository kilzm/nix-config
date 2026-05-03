{
  flake.nixosModules.displaymanager = {
    services.displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };
}
