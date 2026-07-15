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
      slack
      signal-desktop

      libreoffice
      vlc
      musescore
      gimp3-with-plugins
      obs-studio
      zotero

      gf
      imhex
    ];

    programs.thunderbird.enable = true;
  };
}
