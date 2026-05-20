{
  flake.modules.fish.default = {
    pkgs,
    lib,
    ...
  }: {
    runtimePkgs = with pkgs; [
      fzf
    ];

    plugins = with pkgs.fishPlugins; [
      fzf-fish
    ];

    env = {
      FZF_DEFAULT_OPTS = lib.concatStringsSep " " [
        "--ansi"
        "--color=16"
        "--layout reverse"
        "--height 90%"
        "--margin 1"
        "--border none"
      ];
      LS_COLORS = "di=34:ln=36:ex=32";
    };
  };
}
