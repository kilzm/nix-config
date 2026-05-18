{
  flake.homeModules.hyprland = {
    wayland.windowManager.hyprland = {
      enable = true;
      configType = "hyprlang";
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
