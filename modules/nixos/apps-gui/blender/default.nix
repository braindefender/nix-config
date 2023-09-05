{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps-gui.blender;

in {
  options.plusultra.apps-gui.blender = with types; {
    enable = mkBoolOpt false "Enable Blender?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ blender ];
  };
}
