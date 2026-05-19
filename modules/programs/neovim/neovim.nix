{
  inputs,
  self,
  ...
}: {
  flake.modules.neovim.default = {pkgs, ...}: {
    config = {
      settings = {
        config_directory = ./.;
        aliases = ["vi"];
      };

      runtimePkgs = [
        pkgs.wl-clipboard
      ];

      specs.init = {
        data = null;
        before = ["MAIN_INIT"];
        config =
          #lua
          ''
            require('init')
            require('lz.n').load('plugins')
          '';
      };

      specs.general = {
        data = with pkgs.vimPlugins; [
          lz-n
          mini-nvim
          nvim-lspconfig
          nvim-treesitter.withAllGrammars

          blink-cmp
          luasnip
          friendly-snippets

          vim-matchup
          vim-tmux-navigator

          nightfox-nvim
          lazydev-nvim

          gitsigns-nvim
          todo-comments-nvim
          which-key-nvim

          nui-nvim
          noice-nvim
          dropbar-nvim
          alpha-nvim

          render-markdown-nvim
          markdown-preview-nvim

          nvim-dap
          nvim-dap-ui
          nvim-dap-virtual-text
        ];
      };

      specs.lazy = {
        lazy = true;
        data = with pkgs.vimPlugins; [
          flash-nvim
          snacks-nvim
        ];
      };
    };
  };

  perSystem = {pkgs, ...}: {
    packages.neovim = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;
      imports = [
        self.modules.neovim.default
        self.modules.neovim.lsp
      ];
    };

    packages.neovim-minimal = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;
      imports = [
        self.modules.neovim.default
        self.modules.neovim.nix
      ];
    };
  };
}
