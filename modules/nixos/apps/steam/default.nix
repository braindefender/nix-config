{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps.steam;

in {
  options.plusultra.apps.steam = with types; {
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
