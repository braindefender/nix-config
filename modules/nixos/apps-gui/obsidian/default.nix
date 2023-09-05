{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps-gui.obsidian;

in {
  options.plusultra.apps-gui.obsidian = with types; {
    enable = mkBoolOpt false "Enable Obsidian?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ obsidian ];
  };
}
