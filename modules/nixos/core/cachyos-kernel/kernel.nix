{
  flake.nixosModules.cachyos-kernel = {
    lib,
    pkgs,
    ...
  }: {
    boot.kernelPackages = lib.mkDefault pkgs.cachyosKernels.linuxPackages-cachyos-latest;
  };
}
