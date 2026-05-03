{inputs, ...}: {
  flake.homeModules.spicetify = {inputs', ...}: {
    imports = [inputs.spicetify-nix.homeManagerModules.default];

    stylix.targets.spicetify.enable = true;

    programs.spicetify = let
      spicePkgs = inputs'.spicetify-nix.legacyPackages;
    in {
      enable = true;
      wayland = true;

      enabledExtensions = with spicePkgs.extensions; [
        shuffle
        history
        fullAppDisplay
        seekSong
      ];

      enabledCustomApps = with spicePkgs.apps; [
        lyricsPlus
        ncsVisualizer
      ];
    };
  };
}
