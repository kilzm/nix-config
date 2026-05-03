{self, ...}: {
  flake.nixosModules.core = {
    imports = with self.nixosModules; [
      bootloader
      editor
      firmware
      home-manager
      locale
      memory
      network
      nix
      plymouth
      shell
      ssd
      users
    ];
  };
}
