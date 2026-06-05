{self, ...}: {
  flake.modules.neovim.nix = {pkgs, ...}: {
    runtimePkgs = with pkgs; [
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
    runtimePkgs = with pkgs; [
      bash-language-server
      lua-language-server
      clang-tools
      ols
      rust-analyzer
      basedpyright
      typescript-language-server
      vala-language-server
      blueprint-compiler
      mesonlsp
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
          local servers = {
              'bashls',
              'lua_ls',
              'clangd',
              'ols',
              'rust-analyzer',
              'ts_ls',
              'vala_ls',
              'blueprint_ls',
              'mesonlsp',
              'marksman',
              'glsl_analyzer',
              'texlab',
          }
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
