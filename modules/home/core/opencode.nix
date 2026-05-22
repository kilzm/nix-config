{
  flake.homeModules.opencode = {lib, ...}: {
    stylix.targets.opencode.enable = true;

    programs.opencode = {
      enable = true;

      settings = {
        autoupdate = false;
      };

      themes.stylix.theme = {
        background = lib.mkForce {
          dark = "none";
          light = "none";
        };
      };
    };
  };
}
