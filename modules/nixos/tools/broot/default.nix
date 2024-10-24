{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.broot;
in

{
  options.plusultra.tools.broot = with types; {
    enable = mkBoolOpt false "Enable broot?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs.broot = {
        enable = true;
      };
    };
  };
}
