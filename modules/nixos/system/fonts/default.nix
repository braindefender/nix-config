{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.system.fonts;
in

{
  options.plusultra.system.fonts = with types; {
    enable = mkBoolOpt false "Enable fonts configuration?";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ font-manager ];

    fonts = {
      packages = with pkgs; [
        corefonts
        noto-fonts
        noto-fonts-emoji
        cantarell-fonts
        font-awesome
        (nerdfonts.override {
          fonts = [
            "CascadiaCode" # Windows Terminal default font
            "FiraCode" # Best ligature-featured font
            "JetBrainsMono" # Daily-driver for development
          ];
        })
      ] ++ cfg.fonts;

      fontconfig = {
        enable = true;
        antialias = true;
        hinting = {
          enable = true;
          autohint = true;
          style = "full"; # TODO: check
        };

        defaultFonts = {
          emoji = [
            "Segoe UI Emoji"
            "Noto Fonts Emoji"
          ];
        };

        subpixel.lcdfilter = "default"; # TODO: check
      };
    };
  };
}
