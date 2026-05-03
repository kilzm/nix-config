{inputs, ...}: {
  perSystem = {
    lib,
    pkgs,
    self',
    ...
  }: {
    packages.cli-env = pkgs.symlinkJoin {
      name = "cli-env";
      paths =
        (with pkgs; [
          zoxide
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
          python3
        ])
        ++ (with self'.packages; [
          bat
        ]);
    };

    packages.env = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = self'.packages.fish;
      prefixVar = [
        [
          "PATH"
          ":"
          (lib.makeBinPath (
            (with self'.packages; [
              cli-env
              neovim
              tmux
              git
            ])
            ++ (
              with pkgs; [
                direnv
                fzf
                lazygit
              ]
            )
          ))
        ]
      ];
    };
  };
}
