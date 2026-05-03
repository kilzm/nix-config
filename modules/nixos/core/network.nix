{
  flake.nixosModules.network = {
    config,
    lib,
    pkgs,
    inputs',
    ...
  }: let
    inherit
      (lib)
      attrNames
      const
      filterAttrs
      getAttr
      ;
  in {
    networking = {
      nftables.enable = true;
      networkmanager = {
        enable = true;
        plugins = with pkgs; [
          networkmanager-openvpn
        ];
      };
    };

    environment.systemPackages = [
      inputs'.wlctl.packages.default
    ];

    users.extraGroups.networkmanager.members =
      config.users.users |> filterAttrs (const <| getAttr "isNormalUser") |> attrNames;
  };
}
