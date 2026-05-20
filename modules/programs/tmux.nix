{inputs, ...}: {
  perSystem = {
    lib,
    pkgs,
    self',
    ...
  }: {
    packages.tmux = inputs.wrapper-modules.wrappers.tmux.wrap {
      inherit pkgs;

      shell = lib.getExe self'.packages.fish;
      terminal = "tmux-256color";

      sourceSensible = true;
      baseIndex = 1;
      mouse = true;
      escapeTime = 0;
      updateEnvironment = ["TERM"];

      prefix = "C-Space";
      modeKeys = "vi";
      statusKeys = "vi";

      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
        resurrect
      ];

      runtimePkgs = with pkgs; [
        tmux-sessionizer
      ];

      configAfter = let
        c = {
          dark = "#333333";
          base = "#888888";
          light = "#aaaaaa";
        };
      in
        # tmux
        ''
          # binds
          bind | split-window -h -c "#{pane_current_path}"
          bind - split-window -v -c "#{pane_current_path}"
          bind v split-window -h -c "#{pane_current_path}"
          bind h split-window -v -c "#{pane_current_path}"

          bind -r M-h resize-pane -L 5
          bind -r M-j resize-pane -D 5
          bind -r M-k resize-pane -U 5
          bind -r M-l resize-pane -R 5

          ${lib.range 1 9 |> map (n: "bind-key -n M-${toString n} select-window -t ${toString n}") |> lib.concatStringsSep "\n"}

          bind C-o display-popup -E "tms"
          bind C-j display-popup -E "tms switch"
          bind C-w display-popup -E "tms windows"
          bind C-i command-prompt -p "Rename active session to: " "run-shell 'tms rename %1'"
          bind C-l "run-shell 'tms refresh'"

          # border
          set -g pane-border-style fg=${c.dark}
          set -g pane-active-border-style fg=${c.base}

          # status
          set -g status-left-length 40
          set -g status-position top
          set -g status-justify centre

          set -g status-style bg=default,fg=default

          set -g status-left "#[bold,fg=${c.light}]  #H #[nobold,fg=${c.base}]on #[bold,fg=${c.light}]  #S#[nobold]"
          set -g status-right "#[fg=${c.light}]%d-%m-%Y #[fg=${c.base}]at#[fg=${c.light}] %H:%M"


          set -g window-status-format " #[fg=${c.base},bold]#I#[nobold]: #W "
          set -g window-status-current-format \
            "#[fg=${c.dark}]#[bg=${c.dark},fg=${c.light},bold]#I#[nobold]: #W#[fg=${c.dark},bg=default]"
        '';
    };
  };
}
