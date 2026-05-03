{
  inputs,
  self,
  pkgs,
  ...
}:
{
  imports = [
    ./ghostty
    ./zsh
    ./nvim
    ./yazi
    ./btop
    ./browser
    ./spotify
    ./thunderbird
  ];

  home.packages =
    with pkgs;
    [
      qbittorrent-enhanced
      vesktop
      telegram-desktop
      signal-desktop
      zotero
      solaar
      brave
      vlc
      imhex
      pavucontrol
      pwvucontrol
      resources
      obs-studio
      gf
      overskride
    ]
    ++ (with inputs.stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}; [
      protonvpn-gui
    ])
    ++ (with self.packages.${pkgs.stdenv.hostPlatform.system}; [
      gdb-frontend
    ]);

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
      "text/html" = "zen-beta.desktop";
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "application/xhtml+xml" = "zen-beta.desktop";
      "x-scheme-handler/about" = "zen-beta.desktop";
      "x-scheme-handler/unknown" = "zen-beta.desktop";
      "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
    };
  };
}
