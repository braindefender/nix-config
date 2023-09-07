{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps-gui.gparted;

in {
  options.plusultra.apps-gui.gparted = with types; {
    enable = mkBoolOpt false "Enable GParted?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gparted ];
  };
}
