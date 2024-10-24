{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.kitty;
in

{
  options.plusultra.apps.kitty = with types; {
    enable = mkBoolOpt false "Enable Kitty terminal emulator?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      kitty
      kitty-themes
    ];

    plusultra.system.home.extraOptions = {
      programs.kitty = {
        enable = true;

        theme = "Ayu Mirage";
        font.name = "CaskaydiaCove Nerd Font Mono";
        settings = {
          window_padding_width = "1 5";
          enable_audio_bell = false;
        };
        keybindings = {
          "ctrl+c" = "copy_or_interrupt";

          "ctrl+tab" = "neighboring_window right";

          "ctrl+alt+left" = "neighboring_window left";
          "ctrl+alt+right" = "neighboring_window right";
        };
      };
    };
  };
}
