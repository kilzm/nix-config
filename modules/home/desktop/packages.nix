{
  flake.homeModules.desktop = {pkgs, ...}: {
    home.packages = with pkgs; [
      libnotify
      libappindicator
      playerctl
      brightnessctl
      wl-clipboard
      pwvucontrol

      qbittorrent-enhanced
      proton-vpn

      zoom-us
      telegram-desktop
      signal-desktop

      vlc
      musescore
      gimp3-with-plugins
      obs-studio
      zotero

      gf
      imhex
    ];

    programs.onlyoffice.enable = true;
    programs.thunderbird.enable = true;
  };
}
