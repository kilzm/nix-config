{
  flake.homeModules.gnome = {pkgs, ...}: {
    home.packages = with pkgs; [
      loupe
      papers
      nautilus
      showtime
      mission-center
      paper-clip
      impression
      gnome-font-viewer
      gnome-text-editor
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
      gnome-2048
    ];
  };
}
