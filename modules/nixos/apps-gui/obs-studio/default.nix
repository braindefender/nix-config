{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps-gui.obs-studio;

in {
  options.plusultra.apps-gui.obs-studio = with types; {
    enable = mkBoolOpt false "Enable OBS Studio?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ obs-studio ];
  };
}
