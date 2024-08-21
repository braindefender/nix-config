{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.bat;
  aliases = { cat = mkDefault "bat -p"; };
in
{
  options.plusultra.tools.bat = with types; {
    enable = mkBoolOpt false "Enable bat?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        bat = {
          enable = true;

          extraPackages = with pkgs.bat-extras; [ batman batgrep ];
        };

        bash.shellAliases = aliases;
        fish.shellAliases = aliases;
        zsh.shellAliases = aliases;
      };
    };
    environment.systemPackages = with pkgs; [ bat ];
  };
}
