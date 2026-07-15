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
          nvim-lspconfig
          nvim-treesitter.withAllGrammars
          (nvim-treesitter.withPlugins (p: [p.tree-sitter-blueprint]))

          blink-cmp
          luasnip
          friendly-snippets
          lazydev-nvim

          vim-matchup
          vim-tmux-navigator

          gitsigns-nvim
          todo-comments-nvim
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

          (pkgs.vimUtils.buildVimPlugin {
            name = "sail-vim";
            src =
              pkgs.fetchFromGitHub {
                owner = "rems-project";
                repo = "sail";
                rev = "0.20.2";
                hash = "sha256-+ixT1tC5afb3BLFKfBUzmQ1UBXx1dyw8rn6+S0y6S1E=";
                sparseCheckout = ["editors/vim"];
              }
              + "/editors/vim";
          })
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
