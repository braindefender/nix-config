{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.tools.helix;

in {
  options.plusultra.tools.helix = with types; {
    enable = mkBoolOpt false "Enable Helix Editor?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ helix ];
  };
}
