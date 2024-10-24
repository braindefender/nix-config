{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.zellij;
in

{
  options.plusultra.tools.zellij = with types; {
    enable = mkBoolOpt false "Enable Zellij?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs.zellij = {
        enable = true;
        # enableZshIntegration = true;
      };
    };
  };
}
