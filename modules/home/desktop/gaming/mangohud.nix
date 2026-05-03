{
  flake.homeModules.gaming = {pkgs, ...}: {
    home.packages = with pkgs; [
      mangohud
    ];

    xdg.configFile."MangoHud/MangoHud.conf".text = ''
      no_display
      cpu_stats
      gpu_stats
      gpu_temp
      ram
      vram
      frametime
      engine_version
    '';
  };
}
