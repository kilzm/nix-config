{
  pkgs,
  config,
  ...
}:
{
  theming.qt = {
    package = pkgs.adwaita-qt;
    name = "Adwaita-dark";
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style = {
      name = "adwaita-dark";
    };
  };

  home.packages = with pkgs; [
    adwaita-qt
    adwaita-qt6
    qt5.qtwayland
    qt6.qtwayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      env = [
        # Qt theming
        "QT_QPA_PLATFORMTHEME,gtk3"
        "QT_STYLE_OVERRIDE,adwaita-dark"

        # Wayland support
        "QT_QPA_PLATFORM,wayland"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"

        # Optional: if you want Qt5 apps to also use Wayland
        "QT_QPA_PLATFORM,wayland;xcb" # Falls back to X11 if Wayland fails
      ];
    };
  };
}
