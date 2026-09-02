{
  flake.nixosModules.gaming = {pkgs, ...}: {
    programs.gamescope = {
      enable = true;
      capSysNice = false;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
    programs.gamemode.enable = true;

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraPackages = with pkgs; [
        SDL2
        gamescope
      ];
      protontricks.enable = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      heroic
      protonplus
      lutris
      bottles
    ];
  };
}
