{
  pkgs,
  inputs,
  ...
}:
let
  config-plugin = pkgs.vimUtils.buildVimPlugin {
    pname = "nvim-config";
    version = "";
    doCheck = false;
    src = ./src;
  };
in
{
  home.packages = with pkgs; [
    neovim-remote
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraPackages =
      with pkgs;
      [
        bash-language-server
        nil
        nixd
        lua-language-server
        texlab
        diagnostic-languageserver
        # ols
        marksman
        jdt-language-server
        glsl_analyzer
        typescript-language-server
        basedpyright
        clang-tools
      ]
      ++ (with inputs.stable.legacyPackages.${pkgs.stdenv.hostPlatform.system}; [
      ]);

    plugins =
      (with pkgs.vimPlugins; [
        # theme
        nightfox-nvim
        gruvbox-material-nvim

        # visual
        nvim-web-devicons
        vim-matchup
        alpha-nvim
        dropbar-nvim
        nui-nvim
        noice-nvim
        render-markdown-nvim

        mini-nvim

        # code navigation
        vim-tmux-navigator
        flash-nvim

        # language support
        nvim-treesitter.withAllGrammars
        nvim-lspconfig
        blink-cmp
        luasnip
        friendly-snippets
        markdown-preview-nvim
        lazydev-nvim

        # debugging
        nvim-dap
        nvim-dap-ui
        nvim-dap-virtual-text

        # utility
        gitsigns-nvim
        todo-comments-nvim
        snacks-nvim
        which-key-nvim
      ])
      ++ [ config-plugin ];

    initLua = ''
      require('config').init()
    '';
  };
}
