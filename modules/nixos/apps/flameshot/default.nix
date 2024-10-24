{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.flameshot;
  username = config.plusultra.user.name;
  savePath = "${config.users.users.${username}.home}/nexus/images/screens";
in

{
  options.plusultra.apps.flameshot = with types; {
    enable = mkBoolOpt false "Enable Flameshot?";
  };

  # note: not working on wayland

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      services.flameshot = {
        enable = true;

        settings = {
          General = {
            inherit savePath;
            showHelp = false;
            showSidePanelButton = true;
            showStartupLaunchMessage = false;
            uiColor = "#ffffff";
            contrastOpacity = 188;
            contrastUiColor = "#000000";
            drawColor = "#ff00ff";
            drawThickness = 5;
          };
        };
      };
    };
  };
}
