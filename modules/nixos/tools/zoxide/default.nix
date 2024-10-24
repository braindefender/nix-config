{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.zoxide;
in

{
  options.plusultra.tools.zoxide = with types; {
    enable = mkBoolOpt false "Enable zoxide?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        zoxide = {
          enable = true;
          enableZshIntegration = true;
        };
      };
    };
  };
}
