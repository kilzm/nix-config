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
      diebahn
      blanket
      gnome-font-viewer
      gnome-text-editor
      gnome-music
      gnome-calculator
      gnome-disk-utility
      gnome-calendar
      gnome-weather
      gnome-maps
      gnome-clocks
      gnome-mahjongg
      gnome-2048
    ];
  };
}
