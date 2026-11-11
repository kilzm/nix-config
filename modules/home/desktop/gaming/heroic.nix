{
  flake.homeModules.gaming = {
    config,
    pkgs,
    ...
  }: let
    heroic = pkgs.heroic.override {
      heroic-unwrapped = pkgs.heroic-unwrapped.overrideAttrs (old: {
        postPatch =
          (old.postPatch or "")
          + ''
            substituteInPlace src/backend/main_window.ts \
              --replace-fail '    ...windowProps,' '    ...windowProps, transparent: true,'
          '';
      });
    };
  in {
    home.packages = [heroic];

    xdg.dataFile."heroic/stylix.css".text = let
      c = config.lib.stylix.colors;
      a = toString config.stylix.opacity.applications;
      hex = name: "#${c.${name}}";
      glass = "rgba(${c.base00-rgb-r}, ${c.base00-rgb-g}, ${c.base00-rgb-b}, ${a})";
    in ''
      body.stylix {
        background: transparent;
        --background: ${hex "base01"};
        --background-darker: ${hex "base00"};
        --background-lighter: ${hex "base02"};
        --background-secondary: ${hex "base02"};
        --body-background: var(--background-darker);
        --current-background: var(--body-background);
        --input-background: var(--background-lighter);
        --modal-background: var(--background);
        --modal-border: ${hex "base02"};
        --search-bar-background: ${hex "base02"};
        --search-bar-border: ${hex "base02"};
        --osk-background: var(--body-background);
        --osk-button-background: var(--input-background);
        --osk-button-border: ${hex "base02"};

        --text-default: ${hex "base05"};
        --text-secondary: ${hex "base05"};
        --text-title: ${hex "base06"};
        --text-hover: ${hex "base06"};

        --accent: ${hex "base0D"};
        --accent-overlay: ${hex "base0C"};
        --primary: ${hex "base0D"};
        --primary-hover: ${hex "base0C"};
        --secondary: ${hex "base0E"};
        --link-highlight: ${hex "base0D"};

        --navbar-background: ${hex "base01"};
        --navbar-active-background: ${hex "base02"};
        --navbar-active: ${hex "base05"};
        --navbar-inactive: ${hex "base05"};
        --navbar-accent: ${hex "base0D"};
        --divider: ${hex "base02"};

        --action-icon: ${hex "base04"};
        --action-icon-hover: ${hex "base06"};
        --action-icon-active: ${hex "base0D"};
        --icons-background: ${hex "base01"};
        --icon-disabled: ${hex "base02"};

        --primary-button: ${hex "base0D"};
        --primary-button-overlay: ${hex "base0C"};
        --secondary-button: ${hex "base0E"};
        --button-stroke: ${hex "base0D"};
        --play-button: ${hex "base0B"};
        --install-button: ${hex "base0D"};
        --success-button: ${hex "base0B"};
        --disabled-button: ${hex "base02"};
        --disabled-button-overlay: ${hex "base03"};
        --cancel-button: ${hex "base08"};
        --cancel-button-overlay: ${hex "base08"};
        --tertiary-button: ${hex "base09"};
        --tertiary-button-overlay: ${hex "base09"};

        --success: ${hex "base0B"};
        --success-hover: ${hex "base0B"};
        --danger: ${hex "base08"};
        --danger-hover: ${hex "base08"};
        --status-success: ${hex "base0B"};
        --status-warning: ${hex "base09"};
        --status-danger: ${hex "base08"};
        --status-info: ${hex "base0C"};
        --status-default: ${hex "base04"};

        --anticheat-supported: ${hex "base0B"};
        --anticheat-planned: ${hex "base0D"};
        --anticheat-running: ${hex "base0C"};
        --anticheat-broken: ${hex "base09"};
        --anticheat-denied: ${hex "base08"};

        --gradient-body-background: var(--body-background);
      }

      body.stylix .Sidebar {
        --text-hover: ${hex "base05"};
        --sidebar-background: ${glass};
      }

      body.stylix .button.settings {
        background: var(--background-lighter);
      }
    '';
  };
}
