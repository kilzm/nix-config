{
  flake.nixosModules.displaymanager = {
    services.displayManager = {
      ly.enable = true;
    };
  };
}
