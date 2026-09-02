{
  inputs,
  self,
  ...
}: {
  flake.modules.neovim.default = {
    config,
    pkgs,
    ...
  }: {
    config = {
      settings = {
        config_directory = ./.;
        aliases = ["vi"];
      };

      drv.postInstall = ''
        sed -i 's/^Icon=.*/Icon=nvim/' ${placeholder config.outputName}/share/applications/nvim.desktop
      '';

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
          indent-o-matic
          nvim-lspconfig
          nvim-treesitter.withAllGrammars
          (nvim-treesitter.withPlugins (p: [p.tree-sitter-blueprint]))
          nvim-treesitter-textobjects

          blink-cmp
          luasnip
          friendly-snippets
          lazydev-nvim
          diffview-plus-nvim

          vim-tmux-navigator
          which-key-nvim

          nightfox-nvim
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
