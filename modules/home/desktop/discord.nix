{
  flake.homeModules.discord = {
    stylix.targets.vesktop.enable = true;
    programs.vesktop = {
      enable = true;
      settings = {
        checkUpdates = false;
        customTitleBar = false;
        hardwareAcceleration = true;
      };
    };
  };
}
