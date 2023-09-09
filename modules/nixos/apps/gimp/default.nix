{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps.gimp;

in {
  options.plusultra.apps.gimp = with types; {
    enable = mkBoolOpt false "Enable GIMP?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gimp ];
  };
}
