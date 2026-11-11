{
  flake.homeModules.desktop = {inputs', pkgs, ...}: {
    home.packages = with pkgs; [
      libnotify
      libappindicator
      playerctl
      brightnessctl
      wl-clipboard
      pwvucontrol

      qbittorrent-enhanced
      (proton-vpn.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ [
            (fetchurl {
              url = "https://github.com/ProtonVPN/proton-vpn-gtk-app/pull/152.patch";
              hash = "sha256-rJiIhI/Owpo4tF1TFxA0Qh3aKpAjEeQaSzUSXz3zJrU=";
            })
          ];
      }))

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
    ] ++ [
      inputs'.msga.packages.default
    ];

    programs.thunderbird.enable = true;
  };
}
