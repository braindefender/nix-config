{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.nushell;
  nushell_config = builtins.readFile ./nushell.nu;
  nushell_git_completions = builtins.readFile ./git-completions.nu;
  nushell_combined = builtins.concatStringsSep "\n" [
    nushell_config
    nushell_git_completions
  ];

  home = config.users.users.${config.plusultra.user.name}.home;
  flake_path = "${home}/.setup";
in
{
  options.plusultra.tools.nushell = with types; {
    enable = mkBoolOpt false "Enable Nushell?";
    default = mkBoolOpt false "Set Nushell as default shell?";
  };

  config = mkIf cfg.enable {
    plusultra.user.extraOptions = mkIf cfg.default {
      shell = pkgs.nushell;
    };
    plusultra.system.home.extraOptions = {
      programs = {
        nushell = {
          enable = true;

          configFile.text = nushell_combined;

          extraConfig = ''
            def l [] { ls | sort-by type name -i }
            def nrs [] {
              git -C ${flake_path} add --all
              sudo nixos-rebuild switch --flake "${flake_path}#terra"
            }
          '';
        };
      };
    };
  };
}
