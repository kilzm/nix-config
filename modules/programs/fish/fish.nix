{
  inputs,
  self,
  ...
}: {
  flake.modules.fish.default = {
    pkgs,
    self',
    ...
  }: {
    flags = {
      "--no-config" = false;
    };

    env = {
      fish_greeting = "";
      fish_color_command = "blue";
    };

    runtimePkgs = [
      pkgs.zoxide
      self'.packages.eza
    ];

    configFile.content =
      # fish
      ''
        fish_vi_key_bindings
        zoxide init fish | source
        if type -q direnv
          direnv hook fish | source
        end
      '';
  };

  perSystem = {
    pkgs,
    self',
    ...
  }: {
    packages.fish = inputs.wrapper-modules.wrappers.fish.wrap {
      inherit pkgs;
      _module.args.self' = self';

      imports = [
        self.modules.fish.default
      ];
    };
  };
}
