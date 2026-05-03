{
  inputs,
  lib,
  ...
}: {
  perSystem = {
    pkgs,
    self',
    ...
  }: let
    starshipConfig = (pkgs.formats.toml {}).generate "starship.toml" {
      add_newline = false;
      follow_symlinks = false;

      format = "$directory$git_branch$git_status$character";
      right_format = "$c$cpp$cmake$lua$python$odin$java$docker_context$nix_shell";

      directory = {
        style = "bold blue";
        format = "[  $path ]($style)";
        truncation_length = 4;
      };

      line_break.disabled = true;

      character = {
        disabled = false;
        success_symbol = "[ ](cyan)";
        error_symbol = "[✘ ](red)";
        vimcmd_symbol = "[ ](purple)";
      };

      package.disabled = false;

      git_branch = {
        symbol = "[](bright-black) ";
        style = "fg:white bg:bright-black";
        format = "on [$symbol$branch]($style)[](bright-black) ";
      };

      git_status = {
        format = "[$untracked$staged$modified$renamed$conflicted$ahead_behind]($style)";
        staged = "[+$\{count} ](green)";
        modified = "[!$\{count} ](yellow)";
        renamed = "[»$\{count} ](blue)";
        deleted = "[-$\{count} ](red)";
        untracked = "[?$\{count} ](cyan)";
        stashed = "[≡$\{count} ](bright-purple)";
        conflicted = "[✖$\{count} ](red bold)";
        ahead = "[⇡$\{count} ](bright-cyan)";
        behind = "[⇣$\{count} ](bright-red)";
        diverged = "[⇕⇡$\{ahead_count}⇣$\{behind_count} ](purple)";
      };

      nodejs = {
        symbol = "";
        format = "[$symbol($version) ]($style)";
      };

      c = {
        style = "blue";
        symbol = " ";
        format = "[$symbol($version) ]($style)";
      };

      cpp = {
        style = "blue";
        symbol = " ";
        format = "[$symbol($version) ]($style)";
      };

      cmake = {
        style = "red";
        symbol = " ";
        format = "[$symbol($version) ]($style)";
      };

      lua = {
        style = "yellow";
        symbol = "󰢱 ";
        format = "[$symbol($version) ]($style)";
      };

      python = {
        style = "green";
        symbol = " ";
        format = "[$symbol($version) ]($style)";
      };

      nix_shell = {
        style = "cyan";
        symbol = "󱄅 ";
        format = "[$symbol($name) ]($style)";
      };

      odin = {
        detect_files = ["ols.json"];
        style = "blue";
        symbol = "󰟢 ";
        format = "[$symbol($version) ]($style)";
      };

      java = {
        symbol = " ";
        format = "[$symbol($version) ]($style)";
      };

      docker_context = {
        symbol = " ";
        format = "[$symbol($context) ]($style)";
      };
    };

    fishConfig = let
      eza = lib.getExe self'.packages.eza;
    in
      pkgs.writeText "config.fish"
      # fish
      ''
        fish_vi_key_bindings

        set fish_greeting
        set -g fish_color_command blue

        # disable comma suggestions
        function fish_command_not_found
        end

        alias ls "${eza}"
        alias ll "${eza} -l"
        alias la "${eza} -a"
        alias lt "${eza} --tree"
        alias lla "${eza} -la"

        abbr -a nd nix develop
        abbr -a nr nix run
        abbr -a ns nix shell
        abbr -a nb nix build
        function nsn
            nix shell nixpkgs#$argv[1]
        end
        function nbn
            nix build nixpkgs#$argv[1]
        end
        function nrn
            nix run nixpkgs#$argv[1]
        end

        abbr -a c clear
        abbr -a e yazi

        abbr -a gd git diff
        abbr -a ga git add
        abbr -a gc git commit
        abbr -a gp git push
        abbr -a gu git pull
        abbr -a gl 'git log --all --graph --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n"'
        abbr -a gb git branch
        abbr -a gs git status --short
        abbr -a gi git init
        abbr -a gcl git clone
        abbr -a lg lazygit

        set -x STARSHIP_CONFIG ${starshipConfig}
        ${lib.getExe pkgs.starship} init fish | source
        if type -q fzf
            fzf --fish | source
        end
        if type -q zoxide
            zoxide init fish | source
        end
        if type -q direnv
              direnv hook fish | source
        end
      '';
  in {
    packages.fish = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;
      package = pkgs.fish;
      flags = {
        "-C" = "source ${fishConfig}";
      };
      meta.description = "Configured fish shell using Starship prompt";
    };
  };
}
