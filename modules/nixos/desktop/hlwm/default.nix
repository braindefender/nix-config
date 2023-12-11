{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.hlwm;
  script_xinitrc = builtins.readFile ./script_xinitrc.sh;

  mod = "Mod4"; # Mod1 is Alt, Mod4 is Win
in
{
  options.plusultra.desktop.hlwm = with types; {
    enable = mkBoolOpt false "Enable hlwm Window Manager?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.file = {
      ".xinitrc".text = script_xinitrc;
    };

    plusultra.system.home.extraOptions = {
      xsession.windowManager.herbstluftwm = {
        enable = true;

        tags = [ "Inbox" "Main" "Work" "Code" "Null" "Undef" "Config" "Virt" ];

        settings = {
          focus_follows_mouse = true;
          raise_on_click = true;
          default_frame_layout = "horizontal";
        };

        mousebinds = {
          "${mod}-Button1" = "move";
          "${mod}-Button2" = "zoom";
          "${mod}-Button3" = "resize";
        };

        keybinds = {
          "${mod}-Return" = "spawn ${pkgs.kitty}/bin/kitty";
          "${mod}-space" = "spawn ${pkgs.rofi}/bin/rofi -show drun";

          "${mod}-u" = "split bottom";
          "${mod}-i" = "jumpto urgent";
          "${mod}-o" = "split right";
          "${mod}-p" = "pseudotile toggle";

          "${mod}-Shift-r" = "reload";
          "${mod}-Shift-q" = "close";
          "${mod}-Shift-x" = "quit";

          "${mod}-Up" = "focus up";
          "${mod}-Down" = "focus down";
          "${mod}-Left" = "focus left";
          "${mod}-Right" = "focus right";

          "${mod}-Shift-Up" = "shift up";
          "${mod}-Shift-Down" = "shift down";
          "${mod}-Shift-Left" = "shift left";
          "${mod}-Shift-Right" = "shift right";

          "${mod}-Control-Left" = "use_index -1 --skip-visible";
          "${mod}-Control-Right" = "use_index +1 --skip-visible";
        };
      };
    };
  };
}
