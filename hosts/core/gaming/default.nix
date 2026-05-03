{ pkgs, ... }:
{
  programs.steam.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = false;
  };
  programs.gamemode.enable = true;
  programs.steam = {
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    steam = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          pango
          libthai
          harfbuzz
        ];
    };
  };
  environment.systemPackages = with pkgs; [
    mangohud
    vulkan-tools
  ];

  # services.sunshine = {
  #   enable = true;
  #   autoStart = true;
  #   capSysAdmin = true;
  #   openFirewall = true;
  # };
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="057e", ATTR{idProduct}=="2069", MODE="0666"
  '';

  services.joycond.enable = true;
  programs.joycond-cemuhook.enable = true;
}
