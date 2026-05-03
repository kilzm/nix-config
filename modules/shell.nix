{lib, ...}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: {
    devShells.default =
      pkgs.mkShell.override {
        stdenv = pkgs.clangStdenv;
      } {
        packages = [self'.packages.env];
        shellHook = "exec ${lib.getExe self'.packages.env}";
      };
  };
}
