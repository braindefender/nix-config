{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps.polybar;

in {
  options.plusultra.apps.polybar = with types; {
    enable = mkBoolOpt false "Enable polybar?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ polybar ];
  };
}
