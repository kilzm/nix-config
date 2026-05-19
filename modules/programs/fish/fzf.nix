{
  flake.modules.fish.default = {
    pkgs,
    lib,
    ...
  }: {
    runtimePkgs = with pkgs; [
      fzf
    ];

    configFile.content = "${lib.getExe pkgs.fzf} --fish | source";

    env = {
      FZF_DEFAULT_OPTS = lib.concatStringsSep " " [
        "--ansi"
        "--color=16"
        "--layout reverse"
        "--height 70%"
        "--margin 4%"
        "--border rounded"
      ];
    };
  };
}
