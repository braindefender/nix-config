{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.gtk;
in
{
  options.plusultra.desktop.gtk = with types; {
    enable = mkBoolOpt false "Enable GTK 3/4 configuration?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      gtk = {
        enable = true;

        theme = {
          name = "WhiteSur-Dark";
          package = pkgs.whitesur-gtk-theme;
        };

        iconTheme = {
          name = "WhiteSur-Dark";
          package = pkgs.whitesur-icon-theme;
        };

        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };

        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };
    };
  };
}
