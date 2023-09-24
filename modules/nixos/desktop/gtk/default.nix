{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.gtk;
in
{
  options.plusultra.desktop.gtk = with types; {
    enable = mkBoolOpt false "Enable GTK 3/4 configuration?";
    icon = {
      name = mkOpt str "WhiteSur-Dark" "The name of the icon theme to apply.";
      pkg = mkOpt package pkgs.whitesur-icon-theme "The package to use for the icon theme.";
    };
    theme = {
      name = mkOpt str "WhiteSur-Dark" "The name of the GTK theme to apply.";
      pkg = mkOpt package pkgs.whitesur-gtk-theme "The package to use for the GTK theme.";
    };
    cursor = {
      name = mkOpt str "Bibata-Modern-Ice" "The name of the cursor theme to apply.";
      pkg = mkOpt package pkgs.bibata-cursors "The package to use for the cursor theme.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.icon.pkg
      cfg.theme.pkg
      cfg.cursor.pkg
    ];

    environment.sessionVariables = {
      XCURSOR_THEME = cfg.cursor.name;
    };

    plusultra.system.home.extraOptions = {
      gtk = {
        enable = true;

        theme = {
          name = cfg.theme.name;
          package = cfg.theme.pkg;
        };

        iconTheme = {
          name = cfg.theme.name;
          package = cfg.theme.pkg;
        };

        cursorTheme = {
          name = cfg.cursor.name;
          package = cfg.cursor.pkg;
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
