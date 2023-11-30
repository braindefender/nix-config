{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.leftwm;
in
{
  options.plusultra.desktop.leftwm = with types; {
    enable = mkBoolOpt false "Enable leftwm window manager?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      leftwm
      picom-next
    ];

    services.picom = {
      package = pkgs.picom-next;
    };

    plusultra.system.home.file.".xinitrc".text = ''
      # Activate Universal Layout
      setxkbmap -layout universalLayoutOrtho

      # Launch LeftWM
      exec dbus-launch leftwm

      # Apply high refresh rate via XRandR
      xrandr --output HDMI1 --mode 3440x1440 --rate 99.98
    '';
  };
}
