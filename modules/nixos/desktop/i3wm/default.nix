{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.i3wm;
in
{
  options.plusultra.desktop.i3wm = with types; {
    enable = mkBoolOpt false "Enable i3wm Window Manager?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
    ];

    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;
    services.xserver.displayManager.sddm.setupScript = "xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto";
  };
}
