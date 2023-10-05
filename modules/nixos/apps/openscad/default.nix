{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps.openscad;

in {
  options.plusultra.apps.openscad = with types; {
    enable = mkBoolOpt false "Enable OpenSCAD?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ openscad ];
  };
}
