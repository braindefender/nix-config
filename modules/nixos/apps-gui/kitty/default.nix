{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps-gui.kitty;

in {
  options.plusultra.apps-gui.kitty = with types; {
    enable = mkBoolOpt false "Enable Kitty terminal emulator?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ kitty kitty-themes ];
  };
}
