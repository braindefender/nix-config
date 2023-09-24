{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps.krusader;

in {
  options.plusultra.apps.krusader = with types; {
    enable = mkBoolOpt false "Enable Krusader?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ krusader ];
  };
}
