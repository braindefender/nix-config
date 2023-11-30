{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps.barrier;

in {
  options.plusultra.apps.barrier = with types; {
    enable = mkBoolOpt false "Enable barrier?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ barrier ];
  };
}
