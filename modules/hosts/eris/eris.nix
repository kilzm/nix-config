{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.eris = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.eris];
  };
}
