{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.sedna = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.sedna];
  };
}
