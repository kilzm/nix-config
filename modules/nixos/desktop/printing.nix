{
  flake.nixosModules.printing = {
    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    programs.system-config-printer.enable = true;
  };
}
