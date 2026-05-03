{
  flake.homeModules.user = {lib, ...}: {
    home = {
      username = lib.mkDefault "kilianm";
      homeDirectory = lib.mkDefault "/home/kilianm";
    };
  };
}
