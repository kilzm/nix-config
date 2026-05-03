{
  flake.nixosModules.keyring = {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
    security.pam.services = {
      gdm.enableGnomeKeyring = true;
      gdm-password.enableGnomeKeyring = true;
    };
  };
}
