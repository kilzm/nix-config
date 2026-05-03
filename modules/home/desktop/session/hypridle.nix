{
  flake.homeModules.hypridle = {
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "locinctl lock-session";
          ignore_dbus_inhibit = false;
        };

        listener = [
          {
            timeout = 500;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 1200;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
