{self, ...}: {
  flake.nixosModules.eris = {lib, ...}: {
    home-manager.users.kilianm = {
      imports = with self.homeModules; [
        core
        desktop
        gaming
      ];

      wayland.windowManager.hyprland.settings = let
        xiaomi = "desc:Xiaomi Corporation Mi Monitor 3342300003039";
        dell = "desc:Dell Inc. DELL U2415 7MT0169R0CLS";
      in {
        monitor = lib.mkForce [
          "${dell},1920x1200@60,0x0,1"
          "${xiaomi},2560x1440@165,1920x0,1"
        ];

        workspace =
          lib.range 1 10
          |> map (n: let
            ws = toString n;
            monitor =
              if lib.mod n 2 == 1
              then xiaomi
              else dell;
            default =
              if n <= 2
              then ", default:true"
              else "";
          in "${ws}, monitor:${monitor}${default}");
      };

      home.stateVersion = "26.05";
    };
  };
}
