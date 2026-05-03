{inputs, ...}: {
  flake.homeModules.zen-browser = {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    home.sessionVariables = {
      MOZ_LEGACY_PROFILES = 1;
    };

    programs.zen-browser = {
      enable = true;
    };
  };
}
