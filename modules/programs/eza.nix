{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.eza = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.eza;
      flags = {
        "--icons" = "auto";
        "--git" = true;
        "--header" = true;
        "--group-directories-first" = true;
      };
      env = {
        "EZA_ICON_SPACING" = "2";
      };
    };
  };
}
