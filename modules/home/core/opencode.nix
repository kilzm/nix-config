{
  flake.homeModules.opencode = {lib, ...}: {
    stylix.targets.opencode.enable = true;

    programs.opencode = {
      enable = true;

      settings = {
        autoupdate = false;
        lsp = true;

        permission = {
          external_directory = {
            "~/projects/**" = "allow";
            "~/github/**" = "allow";
          };
        };
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
