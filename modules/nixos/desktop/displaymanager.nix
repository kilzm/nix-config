{
  flake.nixosModules.displaymanager = {lib, pkgs, ...}: {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${lib.getExe pkgs.tuigreet} --time --remember --remember-session --sessions ${pkgs.hyprland}/share/wayland-sessions";
          user = "greeter";
        };
      };
    };
  };
}
