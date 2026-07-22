{inputs, ...}: {
  flake.homeModules.discord = {
    imports = [inputs.nixcord.homeModules.nixcord];

    stylix.targets.nixcord.enable = true;
    programs.nixcord = {
      enable = true;
      discord = {
        vencord.enable = false;
        equicord.enable = true;
      };

      config = {
        frameless = true;
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
