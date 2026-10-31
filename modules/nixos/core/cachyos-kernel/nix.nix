{inputs, ...}: {
  flake.nixosModules.cachyos-kernel = {
    nixpkgs.overlays = [
      inputs.cachyos-kernel.overlays.pinned
    ];

    nix.settings = {
      substituters = ["https://cache.lantian.pub/lantian"];
      trusted-public-keys = ["lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="];
    };
  };
}
