{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.startx;
in
{
  options.plusultra.desktop.wayland = with types; {
    enable = mkBoolOpt false "Enable Wayland configuration?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swww
      wev
      wl-clipboard
      wofi
    ];
  };
}
