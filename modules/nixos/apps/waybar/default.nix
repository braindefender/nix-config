{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.waybar;
  # note: not used for a long time.
in

{
  options.plusultra.apps.waybar = with types; {
    enable = mkBoolOpt false "Enable Waybar?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs.waybar = {
        enable = true;

        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 32;

            modules-left = [ ];
            modules-center = [ ];
            modules-right = [ "tray" "clock#date" "clock#time" ];

            "clock#date" = {
              interval = 10;
              tooltip = false;
              format = "{:%F}";
            };

            "clock#time" = {
              interval = 1;
              tooltip = false;
              format = "{:%H:%M}";
            };
          };
        };
      };
    };
  };
}
