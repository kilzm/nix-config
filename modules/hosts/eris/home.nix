{self, ...}: {
  flake.nixosModules.eris = _: {
    home-manager.users.kilianm = {
      imports = with self.homeModules; [
        core
        desktop
        gaming
      ];

      wayland.windowManager.hyprland.extraLuaFiles."conf.eris" = {
        content =
          # lua
          ''
            hl.monitor({
                output = "desc:Dell Inc. DELL U2415 7MT0169R0CLS",
                mode = "1920x1200@59.95",
                position = "0x0",
                scale = 1,
            })
            hl.monitor({
                output = "desc:Xiaomi Corporation Mi Monitor 3342300003039",
                mode = "2560x1440@165.00",
                position = "1920x0",
                scale = 1,
            })

            for i = 1, 10 do
                local monitor =
                    i % 2 == 1 and "desc:Xiaomi Corporation Mi Monitor 3342300003039"
                    or "desc:Dell Inc. DELL U2415 7MT0169R0CLS"
                hl.workspace_rule({
                    workspace = tostring(i),
                    monitor = monitor,
                    default = i <= 2,
                })
            end
          '';
      };

      home.stateVersion = "26.05";
    };
  };
}
