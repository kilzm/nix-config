{
  inputs,
  pkgs,
  ...
}:
{
  home.packages =
    (with pkgs; [
      bottles
      rare
      lutris
      protonplus
      heroic

      dolphin-emu
      cemu
      azahar
      ryubing
    ])
    ++ (with inputs.stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}; [
    ]);

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
}
