{self, ...}: {
  flake.nixosModules.sedna = _: {
    home-manager.users.kilianm = {
      imports = with self.homeModules; [
        core
        desktop
      ];

      wayland.windowManager.hyprland.extraLuaFiles."conf.sedna" = {
        content =
          # lua
          ''
            hl.monitor({
                output = "eDP-1",
                mode = "2160x1440@60",
                position = "0x0",
                scale = 1,
            })
            hl.monitor({
                output = "",
                mode = "preferred",
                position = "auto",
                scale = 1,
                mirror = "eDP-1",
            })

            hl.config({ input = { sensitivity = 0.5 } })
          '';
      };

      programs.ghostty.settings.font-size = 14;

      home.stateVersion = "26.05";
    };
  };
}
