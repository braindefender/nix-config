{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps-cli.helix;

in {
  options.plusultra.apps-cli.helix = with types; {
    enable = mkBoolOpt false "Enable Helix Editor?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ helix ];
  };
}
