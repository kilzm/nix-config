{
  flake.homeModules.fzf = {lib, ...}: {
    stylix.targets.fzf.enable = true;
    programs.fzf = {
      enable = true;
      defaultOptions = [
        "--layout reverse"
        "--height 70%"
        "--margin 4%"
        "--border rounded"
      ];
      colors.bg = lib.mkForce "-1";
    };
  };
}
