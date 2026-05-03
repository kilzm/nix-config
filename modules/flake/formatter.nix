{inputs, ...}: {
  imports = [
    inputs.treefmt-nix.flakeModule
  ];

  perSystem = {
    treefmt = {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;
        statix.enable = true;
        deadnix.enable = true;
        prettier.enable = true;
        stylua = {
          enable = true;
          settings = {
            indent_type = "Spaces";
            indent_width = 4;
            column_width = 100;
          };
        };
      };
    };
  };
}
