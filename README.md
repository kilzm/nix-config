<h1 align="center">
    <img src="./.github/assets/logo/nix.png" width=120px/>
    <br>
      Nix Configurations
</h1>

This repo contains my personal configurations for NixOS, home-manager using the [dendritic pattern](https://github.com/mightyiam/dendritic) with [flake-parts](https://github.com/hercules-ci/flake-parts) and [import-tree](https://github.com/denful/import-tree).

### Wrappers

Some programs are configured as wrappers using [nix-wrapper-modules](https://github.com/BirdeeHub/nix-wrapper-modules).
These can be ran on any system that has Nix regardless of NixOS/home-manager setup (e.g. `nix run github:kilzm/nix-config#neovim`).

### Shell Environment

My shell environment consisting of a customized fish shell, program wrappers and utilities is exposed as package (`nix shell github:kilzm/nix-config#env`) and a devshell (`nix develop github:kilzm/nix-config`).

### References

- [bivsk/nix-iv](https://github.com/bivsk/nix-iv)
- [vic/vix](https://github.com/vic/vix)
- [vimjoyer/nixconf](https://github.com/vimjoyer/nixconf)
