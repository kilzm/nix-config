{inputs, ...}: {
  perSystem = {
    lib,
    pkgs,
    self',
    ...
  }: {
    packages.cli-env = pkgs.symlinkJoin {
      name = "cli-env";
      paths = with pkgs; [
        htop
        killall
        pciutils
        usbutils
        evtest
        netcat
        wget
        _7zz
        ripgrep
        imagemagick
        libqalculate
        fd
        jq
        dust
        trashy
        gdb
        gef
        lldb
        gcc
        python3
      ];
    };

    packages.env = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = self'.packages.fish;
      prefixVar = let
        packages =
          (with self'.packages; [
            cli-env
            neovim
            tmux
            git
          ])
          ++ (with pkgs; [
            direnv
            lazygit
            zoxide
            bat
          ]);
      in [
        ["PATH" ":" lib.makeBinPath packages]
      ];
    };
  };
}
