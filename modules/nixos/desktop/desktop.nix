{self, ...}: {
  flake.nixosModules.desktop = {
    imports = with self.nixosModules; [
      bluetooth
      displaymanager
      fonts
      graphics
      hyprland
      keyring
      printing
      sound
      usb
    ];
  };
}
