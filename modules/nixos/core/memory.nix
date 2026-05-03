{
  flake.nixosModules.memory = {
    zramSwap = {
      enable = true;
      priority = 100;
      memoryPercent = 30;
      algorithm = "lz4";
    };

    boot.kernelParams = [
      "vm.swappiness=10"
      "transparent_hugepage=madvise"
    ];

    services.earlyoom.enable = true;
  };
}
