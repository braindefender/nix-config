{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.startx;
in

{
  options.plusultra.desktop.startx = with types; {
    enable = mkBoolOpt false "Enable startx?";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
    services.xserver.displayManager.startx.enable = true;

    plusultra.system.home.extraOptions = {
      programs.zsh.loginExtra = ''
        if [ -z "''${DISPLAY}" ] && [ $(tty) = "/dev/tty1" ]; then
          startx
        fi
      '';
    };
  };
}
