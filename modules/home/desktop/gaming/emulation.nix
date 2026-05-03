{
  flake.homeModules.gaming = {pkgs, ...}: {
    home.packages = with pkgs; [
      dolphin-emu
      azahar
      cemu
      ryubing
    ];
  };
}
