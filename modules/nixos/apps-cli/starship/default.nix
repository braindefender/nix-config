{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps-cli.starship;
  starshipConfig = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    settings = {
      format = "$all$fill$cmd_duration$line_break$shell$character";

      username = {
        show_always = true;
        format = "[$user]($style) [@](8) ";
        style_user = "red bold";
      };

      hostname = {
        disabled = false;
        ssh_only = false;
        format = "[$hostname]($style) [in](8) ";
        style = "yellow bold";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = false;
        read_only = " ";
        style = "green bold";
      };

      git_branch = {
        symbol = " ";
        format = "[on](8) [$symbol$branch(:$remote_branch)]($style) ";
        style = "cyan bold";
      };

      fill = {
        symbol = " ";
      };

      time = {
        disabled = true;
        time_format = "%T";
        foromat = "[$time]($style)";
        style = "8";
      };

      character = {
        success_symbol = "[❱](bold blue)[❱](bold cyan)[❱](bold green)[❱](bold yellow)[❱](bold red)";
        error_symbol = "[](bold blue)[](bold cyan)[](bold green)[](bold yellow)[](bold red)";
      };
    };
  };
in
{
  options.plusultra.apps-cli.starship = with types; {
    enable = mkBoolOpt false "Enable Starship command-line prompt?";
  };

  config = mkIf cfg.enable {
    # user-home-wide
    plusultra.system.home.extraOptions = {
      programs.starship = starshipConfig;
    };
  };
}
