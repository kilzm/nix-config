{self, ...}: {
  flake.homeModules.desktop = {
    imports = with self.homeModules; [
      ghostty
      gnome
      session
      zen-browser
      discord
      qt
      spicetify
    ];
  };
}
