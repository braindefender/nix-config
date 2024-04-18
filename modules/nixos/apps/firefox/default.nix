{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.firefox;
  defaultSettings = {
    "browser.aboutwelcome.enabled" = false;
    "browser.aboutConfig.showWarning" = false;
    "browser.urlbar.suggest.quicksuggest.sponsored" = false;
  };
in
{
  options.plusultra.apps.firefox = with types; {
    enable = mkBoolOpt false "Enable Firefox?";
    extraConfig = mkOpt str "" "Extra configuration for the user profile JS file.";
    userChrome = mkOpt str "" "Extra configuration for the user chrome CSS file.";
    settings = mkOpt attrs defaultSettings "Settings to apply to the profile";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ firefox ];

    plusultra.system.home.extraOptions = {
      programs.firefox = {
        enable = true;

        profiles.${config.plusultra.user.name} = {
          inherit (cfg) extraConfig userChrome settings;
          id = 0;
          name = config.plusultra.user.name;
          extensions = with pkgs.nur.repos.rycee.firefox-addons; [
            enhancer-for-youtube
            react-devtools
            sponsorblock
            stylus
            ublock-origin
            vimium
            # tweak and savefrom are not present :(
          ];
        };
      };
    };
  };
}
