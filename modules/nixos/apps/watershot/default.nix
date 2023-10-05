{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps.watershot;

in {
  options.plusultra.apps.watershot = with types; {
    enable = mkBoolOpt false "Enable Watershot?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ watershot ];
  };
}
