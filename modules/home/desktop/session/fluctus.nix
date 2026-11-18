{
  flake.homeModules.fluctus = {
    inputs,
    pkgs,
    ...
  }: {
    home.packages = [
      inputs.fluctus.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
