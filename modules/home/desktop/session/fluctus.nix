{
  flake.homeModules.fluctus = {
    inputs,
    pkgs,
    ...
  }: {
    home.packages = [
      inputs.fluctus-shell.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
