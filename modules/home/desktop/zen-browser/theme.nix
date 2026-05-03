{
  flake.homeModules.zen-browser = {config, ...}: {
    programs.zen-browser.profiles.default = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.allow_transparent_browser" = true;
        "widget.transparent-windows" = true;
        "zen.widget.linux.transparency" = true;
        "zen.view.grey-out-inactive-windows" = false;
      };

      userChrome = let
        c = config.lib.stylix.colors;
        color = "rgba(${c.base00-rgb-r}, ${c.base00-rgb-g}, ${c.base00-rgb-b}, ${toString config.stylix.opacity.applications})";
      in ''
        * {
          font-family: ${config.stylix.fonts.sansSerif.name};
        }
        .zen-browser-generic-background {
          --zen-themed-toolbar-bg: ${color} !important;
          --toolbar-bgcolor: ${color} !important;
          --toolbox-bgcolor-inactive: ${color} !important;
          --zen-main-browser-background: ${color} !important;
          --newtab-background-color: ${color} !important;
          --lwt-sidebar-background-color: ${color} !important;
        }
      '';
    };
  };
}
