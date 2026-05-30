{inputs, ...}: {
  flake.nixosModules.nix = {config, ...}: {
    imports = [
      inputs.nix-index-database.nixosModules.nix-index
    ];

    programs.nix-index.enableFishIntegration = false;
    programs.nix-index-database.comma.enable = true;

    nixpkgs.config.allowUnfree = true;
    nix = {
      channel.enable = false;
      settings = {
        experimental-features = ["nix-command" "flakes" "pipe-operators"];
        auto-optimise-store = true;
        keep-outputs = true;
        keep-derivations = true;
        warn-dirty = false;
        trusted-users = ["@wheel"];
      };
    };

    programs.nh = {
      enable = true;
      flake = "${config.home-manager.users.kilianm.home.homeDirectory}/nix-config";
      clean = {
        enable = true;
        dates = "daily";
        extraArgs = "--keep 1 --keep-since 8d";
      };
    };
  };
}
