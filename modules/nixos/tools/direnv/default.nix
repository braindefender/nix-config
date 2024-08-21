{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.tools.direnv;

in
{
  options.plusultra.tools.direnv = with types; {
    enable = mkBoolOpt false "Enable nix-direnv?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        direnv = {
          enable = true;

          silent = true;
          enableZshIntegration = true;
          nix-direnv.enable = true;
        };
      };
    };
  };
}
