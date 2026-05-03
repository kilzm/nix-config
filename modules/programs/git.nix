{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages.git = inputs.wrapper-modules.wrappers.git.wrap {
      inherit pkgs;
      settings = {
        user = {
          name = "Kilian Markl";
          email = "kilian02.markl@gmail.com";
        };
        core = {
          whitespace = "trailing-space, space-before-tab";
          preloadindex = true;
        };
        "url \"git@github.com:kilzm/\"" = {
          insteadOf = "km:";
        };
        "url \"git@github.com:\"" = {
          insteadOf = "gh:";
        };
        status = {
          branch = true;
          showStash = true;
        };
        pull.rebase = true;
        rebase = {
          autoStash = true;
          missingCommitsCheck = "warn";
        };
        credential = {
          helper = "store";
        };
      };
    };
  };
}
