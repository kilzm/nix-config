{
  flake.nixosModules.desktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      ghostty
    ];
    programs.dconf = {
      enable = true;
    };
    services.gvfs = {
      enable = true;
    };
    programs.ausweisapp = {
      enable = true;
    };
    programs.appimage = {
      binfmt = true;
      enable = true;
    };
  };
}
