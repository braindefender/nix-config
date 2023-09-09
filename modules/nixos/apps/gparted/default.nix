{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps.gparted;

in {
  options.plusultra.apps.gparted = with types; {
    enable = mkBoolOpt false "Enable GParted?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gparted ];
  };
}
