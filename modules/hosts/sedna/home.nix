{self, ...}: {
  flake.nixosModules.sedna = {lib, ...}: {
    home-manager.users.kilianm = {
      imports = with self.homeModules; [
        core
        desktop
      ];

      wayland.windowManager.hyprland.settings = {
        monitor = lib.mkForce [
          "eDP-1,2160x1440@60,0x0,1"
          ",preferred,auto,1,mirror,eDP-1"
        ];
        input.sensitivity = 0.5;
      };

      programs.ghostty.settings.font-size = 14;

      home.stateVersion = "26.05";
    };
  };
}
