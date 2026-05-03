{self, ...}: {
  flake.modules.neovim.nix = {pkgs, ...}: {
    extraPackages = with pkgs; [
      nixd
      alejandra
    ];

    specs.nix = {
      data = [pkgs.vimPlugins.nvim-lspconfig];
      config =
        # lua
        ''
          vim.lsp.config("nixd", {
              cmd = { "nixd" },
              settings = {
                  nixd = {
                      nixpkgs = {
                          expr = "import <nixpkgs> { }",
                      },
                      formatting = {
                          command = { "alejandra" },
                      },
                  },
              },
          })
          vim.lsp.enable("nixd")
        '';
    };
  };

  flake.modules.neovim.lsp = {pkgs, ...}: {
    extraPackages = with pkgs; [
      bash-language-server
      lua-language-server
      clang-tools
      ols
      rust-analyzer
      basedpyright
      typescript-language-server
      marksman
      glsl_analyzer
      texlab
    ];
    imports = [
      self.modules.neovim.nix
    ];
    specs.lsp = {
      data = with pkgs.vimPlugins; [
        blink-cmp
        nvim-lspconfig
      ];
      config =
        # lua
        ''
          local capabilities = require('blink.cmp').get_lsp_capabilities({})
          local servers = { 'bashls', 'lua_ls', 'clangd', 'ols', 'rust-analyzer', 'ts_ls', 'marksman', 'glsl_analyzer', 'texlab' }
          for _, server in ipairs(servers) do
              vim.lsp.enable(server)
              vim.lsp.config(server, {
                  capabilities = capabilities,
              })
          end

          vim.lsp.enable('basedpyright')
          vim.lsp.config('basedpyright', {
              capabilities = capabilities,
              settings = {
                  basedpyright = {
                      analysis = {
                          diagnosticMode = "workspace",
                      },
                  },
              },
          })
        '';
    };
  };
}
