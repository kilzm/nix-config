{
  flake.modules.fish.default = {
    pkgs,
    lib,
    ...
  }: let
    config = (pkgs.formats.toml {}).generate "starship.toml" {
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
  in {
    env = {
      STARSHIP_CONFIG = config;
    };
    configFile.content =
      # fish
      ''${lib.getExe pkgs.starship} init fish | source'';
  };
}
