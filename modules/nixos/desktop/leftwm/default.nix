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
      exec dbus-launch leftwm
      setxkbmap -layout universalLayoutOrtho
    '';
  };
}
