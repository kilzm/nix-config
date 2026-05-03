{
  flake.nixosModules.users = {
    users = {
      users.kilianm = {
        isNormalUser = true;
        description = "Kilian";
        extraGroups = ["wheel"];
      };
    };
  };
}
