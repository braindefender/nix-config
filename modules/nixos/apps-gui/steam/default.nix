{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps-gui.steam;

in {
  options.plusultra.apps-gui.steam = with types; {
    enable = mkBoolOpt false "Enable Steam?";
  };

  config = mkIf cfg.enable {
    programs = {
      steam = {
        enable = true;
	remotePlay.openFirewall = true;
      };
    };
  };
}
