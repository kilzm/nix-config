{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.bat = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.bat;
      flagSeparator = "=";
      flags = {
        "--theme" = "ansi";
      };
    };
  };
}
