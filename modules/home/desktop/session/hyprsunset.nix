{
  flake.homeModules.hyprsunset = {
    services.hyprsunset = {
      enable = true;
      settings = {
        transition = 60;
        profile = [
          {
            time = "8:00";
            identity = true;
          }
          {
            time = "23:00";
            temperature = 5500;
          }
        ];
      };
    };
  };
}
