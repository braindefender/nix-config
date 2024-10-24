{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.zsh;
in

{
  options.plusultra.tools.zsh = with types; {
    enable = mkBoolOpt false "Enable ZSH?";
    default = mkBoolOpt false "Set ZSH as default shell?";
  };

  config = mkIf cfg.enable {
    plusultra.user.extraOptions = mkIf cfg.default {
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;

    plusultra.system.home.extraOptions = {
      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;

          initExtra = ''
            export KEYTIMEOUT=1

            # Use vim bindings
            set -o vi

            # Improved vim bindings
            source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
          '';

          plugins = [ ];
        };
      };
    };
  };
}
