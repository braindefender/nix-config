{ options, config, lib, pkgs, host ? "", format ? "", ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.services.flameshot;
  username = config.plusultra.user.name;
in
{
  options.plusultra.services.flameshot = with types;
    {
      enable = mkBoolOpt false "Enable Flameshot?";
    };

  # note: not working on wayland

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      services.flameshot = {
        enable = true;

        settings = {
          General = {
            showHelp = false;
            showSidePanelButton = true;
            showStartupLaunchMessage = false;
            uiColor = "#ffffff";
            contrastOpacity = 188;
            contrastUiColor = "#000000";
            drawColor = "#ff00ff";
            drawThickness = 5;
            savePath = "${config.users.users.${username}.home}/Screenshots";
          };
        };
      };
    };
  };
}
