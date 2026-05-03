{
  flake.homeModules.gnome = {pkgs, ...}: {
    home.packages = with pkgs; [
      loupe
      papers
      nautilus
      showtime
      resources
      gnome-font-viewer
      gnome-usage
      gnome-music
      gnome-calculator
      gnome-disk-utility
      gnome-system-monitor
      gnome-calendar
      gnome-weather
      gnome-maps
      gnome-clocks
      gnome-mahjongg
    ];
  };
}
