{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.lf;
in
{
  options.plusultra.tools.lf = with types; {
    enable = mkBoolOpt false "Enable lf file manager?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs.lf = {
        enable = true;

        keybindings = {
          d = "cut";
          D = "delete";
        };
      };
    };

    environment.systemPackages = with pkgs; [ lf ];
  };
}
