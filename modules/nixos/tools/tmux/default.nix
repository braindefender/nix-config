{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.tmux;
  # note: deprecated. use zellij instead
in

{
  options.plusultra.tools.tmux = with types; {
    enable = mkBoolOpt false "Enable tmux?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs.tmux = {
        enable = true;

        clock24 = true;
        baseIndex = 1;
        keyMode = "vi";
        customPaneNavigationAndResize = true;
        prefix = "C-a";
        terminal = "xterm-256color";
        escapeTime = 10;
        aggressiveResize = true;

        extraConfig = ''
          set-option -ga terminal-overrides ",xterm-256color:Tc"

        '';

        plugins = with pkgs; [
          {
            plugin = tmuxPlugins.continuum;
            extraConfig = ''
              set -g @continuum-restore 'on'
              set -g @continuum-save-interval '30'

              unbind-key -n '~'

              bind -N "Select pane to the left of the active pane" j select-pane -L
              bind -N "Select pane below the active pane" k select-pane -D
              bind -N "Select pane above the active pane" l select-pane -U
              bind -N "Select pane to the right of the active pane" '~' select-pane -R

              unbind-key -n C-M-E
              bind -N "Detach client from the current session" C-M-E detach-client

              unbind r
              bind r source-file ~/.config/tmux.conf
            '';
          }
          {
            plugin = tmuxPlugins.extrakto;
            extraConfig = ''
              set -g @extrakto_split_direction 'v'
            '';
          }
        ];
      };
    };
  };
}
