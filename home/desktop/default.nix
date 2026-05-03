{
  inputs,
  pkgs,
  host,
  ...
}:
{
  imports = [
    ./${host}.nix
    ./hyprland
    # ./ags
    ./gnome
    ./qt
    ./waypaper
  ];

  theming = {
    cursors = {
      name = "phinger-cursors-dark";
      package = pkgs.phinger-cursors;
    };
  };

  programs.onlyoffice = {
    enable = true;
  };

  home.packages = with pkgs; [
    inputs.fluctus.packages.${pkgs.stdenv.hostPlatform.system}.default

    libnotify
    musescore
    libappindicator
    awww
    networkmanagerapplet
    playerctl
    brightnessctl
    wl-clipboard
    zoom-us
    element-desktop
    gimp3-with-plugins
  ];
}
