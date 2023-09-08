{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.shell.direnv;

in
{
  options.plusultra.shell.direnv = with types; {
    enable = mkBoolOpt false "Enable nix-direnv?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        direnv = {
          enable = true;
          enableBashIntegration = true;
          enableFishIntegration = true;
          enableZshIntegration = true;
          enableNushellIntegration = true;
          nix-direnv.enable = true;
        };
      };
    };
  };
}
