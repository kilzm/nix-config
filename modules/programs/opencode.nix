{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.opencode = inputs.wrapper-modules.wrappers.opencode.wrap {
      inherit pkgs;
      settings = {
        autoupdate = false;
        lsp = true;
        permission.external_directory = {
          "~/projects/**" = "allow";
          "~/github/**" = "allow";
        };
        theme = "system";
      };
    };
  };
}
