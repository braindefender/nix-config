{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps.figma;

in {
  options.plusultra.apps.figma = with types; {
    enable = mkBoolOpt false "Enable Figma?";
  };

  config = mkIf cfg.enable {
    # TODO: Add Figma PWA somehow...
    environment.systemPackages = with pkgs; [ figma-agent ];
  };
}
