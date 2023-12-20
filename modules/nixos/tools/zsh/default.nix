{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.zsh;
  home = config.users.users.${config.plusultra.user.name}.home;
  flake_path = "${home}/.setup";
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
          enableAutosuggestions = true;
          syntaxHighlighting.enable = true;

          initExtra = ''
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
