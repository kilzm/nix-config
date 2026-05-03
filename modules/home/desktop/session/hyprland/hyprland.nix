{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
      xwayland = {
        enable = true;
      };
    };
  };
}
