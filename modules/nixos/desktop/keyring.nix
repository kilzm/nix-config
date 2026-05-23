{
  flake.nixosModules.keyring = {
    services.gnome.gnome-keyring.enable = true;
    programs.seahorse.enable = true;
    security.pam.services = {
      greetd.enableGnomeKeyring = true;
    };
  };
}
