{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.eza;
in

{
  options.plusultra.tools.eza = with types; {
    enable = mkBoolOpt false "Enable eza?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        eza = {
          enable = true;
          enableZshIntegration = true;

          git = true;
          icons = true;
          extraOptions = [
            "--group-directories-first"
            "--time-style=long-iso"
          ];
        };
      };
    };
  };
}
