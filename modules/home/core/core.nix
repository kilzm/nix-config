{self, ...}: {
  flake.homeModules.core = {
    imports = with self.homeModules; [
      bat
      btop
      direnv
      git
      mime
      neovim
      shell
      tldr
      tmux
      user
      yazi
    ];

    programs.home-manager.enable = true;
    systemd.user.startServices = "sd-switch";
  };
}
