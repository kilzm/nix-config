{
  flake.nixosModules.ssd = {
    services.fstrim = {
      enable = true;
      interval = "weekly";
    };
  };
}
