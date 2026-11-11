{inputs, ...}: {
  flake.homeModules.discord = {config, ...}: {
    imports = [inputs.nixcord.homeModules.nixcord];

    stylix.targets.nixcord = {
      enable = true;
      extraCss = let
        c = config.lib.stylix.colors;
        a = toString config.stylix.opacity.applications;
        color = "rgba(${c.base00-rgb-r}, ${c.base00-rgb-g}, ${c.base00-rgb-b}, ${a})";
      in
        # css
        ''
          html,
          body,
          #app-mount {
              background: transparent !important;
          }

          #app-mount [class*="app_"] {
              background: transparent !important;
          }

          #app-mount [class*="bg_"] {
              background: ${color} !important;
          }

          [class*="sidebar_"]:has(nav[class*="guilds_"]) {
              background: transparent !important;
          }

          [class*="sidebar_"]:has(nav[class*="guilds_"])::after {
              background: transparent !important;
          }

          [class*="sidebarList_"] {
              background: var(--background-base-lower) !important;
              border-start-start-radius: var(--radius-md, 8px);
          }

          nav[class*="guilds_"] {
              background: transparent !important;
          }

          [class^="chat_"] {
              background: transparent !important;
          }

          [class^="chat_"] > [class*="header_"] {
              background: transparent !important;
          }
        '';
    };

    programs.nixcord = {
      enable = true;
      discord.enable = false;
      equibop.enable = true;

      config = {
        frameless = true;
        transparent = true;
        useQuickCss = true;
        plugins = {
          alwaysExpandRoles.enable = true;
          anonymiseFileNames.enable = true;
          betterGifPicker.enable = true;
          betterRoleDot.enable = true;
          betterSettings.enable = true;
          betterUploadButton.enable = true;
          dearrow.enable = true;
          fakeNitro.enable = true;
          biggerStreamPreview.enable = true;
          disableCallIdle.enable = true;
          serverInfo.enable = true;
          declutter = {
            enable = true;
            removeClanTag = false;
          };
        };
      };
    };
  };
}
