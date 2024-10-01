{ config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.niri;
in
{
  options.plusultra.desktop.niri = with types; {
    enable = mkBoolOpt false "Enable Niri Window Manager?";
  };

  config = mkIf cfg.enable {
    plusultra.desktop.wayland = enabled;

    environment.systemPackages = with pkgs; [ niri ];

    plusultra.system.home.file = {
      ".config/niri/config.kdl".text = ''
        screenshot-path "~/nexus/areas/Images/Screenshots/%Y-%m-%d %H-%M-%S.png"

        prefer-no-csd

        output "HDMI-A-1" {
          mode "3440x1440@99.982"
          scale 1
          transform "normal"
          position x=0 y=0
        }

        cursor {
          xcursor-theme "Bibata-Modern-Ice"
          xcursor-size 24
        }

        hotkey-overlay {
          skip-at-startup
        }

        input {
          keyboard {
            xkb {
              layout "universalLayoutOrtho"
            }
          }
          touchpad {
            off
          }
          warp-mouse-to-focus

          focus-follows-mouse max-scroll-amount="0%"
        }

        layout {
          gaps 16
          center-focused-column "on-overflow"

          preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
          }

          default-column-width {
            proportion 0.5;
          }

          focus-ring {
            width 3

            active-color "#7fc8ff"
            inactive-color "#505050"
          }

          border {
            off
            width 3

            active-color "#ffc87f"
            inactive-color "#505050"
          }

          struts {
            top 0
            left 0
            right 0
            bottom 0
          }
        }

        binds {
          Mod+Shift+Escape { quit; }

          Mod+Space  { spawn "${pkgs.wofi}/bin/wofi" "--show" "drun"; }
          Mod+Return { spawn "${pkgs.kitty}/bin/kitty"; }

          Print { screenshot; }
          Ctrl+Print { screenshot-screen; }
          Alt+Print { screenshot-window; }

          Mod+Comma   { consume-window-into-column; }
          Mod+Period  { expel-window-from-column; }
          Mod+R       { switch-preset-column-width; }
          Mod+Shift+R { reset-window-height; }
          Mod+C       { center-column; }
          Mod+F       { maximize-column; }
          Mod+Shift+F { fullscreen-window; }
          Mod+Q       { close-window; }


          Mod+Minus       { set-column-width "-10%"; }
          Mod+Equal       { set-column-width "+10%"; }
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }

          Mod+Up    { focus-workspace-up; }
          Mod+Down  { focus-workspace-down; }
          Mod+Left  { focus-window-up-or-column-left; }
          Mod+Right { focus-window-down-or-column-right; }

          Mod+Shift+Up    { move-window-up; }
          Mod+Shift+Down  { move-window-down; }
          Mod+Shift+Left  { move-column-left; }
          Mod+Shift+Right { move-column-right; }

          Mod+Home      { focus-column-first; }
          Mod+End       { focus-column-last; }
          Mod+Ctrl+Home { move-column-to-first; }
          Mod+Ctrl+End  { move-column-to-last; }

          Mod+Page_Up        { focus-workspace-up; }
          Mod+Page_Down      { focus-workspace-down; }
          Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
          Mod+Ctrl+Page_Down { move-column-to-workspace-down; }

          Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
          Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
          Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }
          Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }

          Mod+Shift+WheelScrollDown      { focus-column-right; }
          Mod+Shift+WheelScrollUp        { focus-column-left; }
          Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
          Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

          Mod+1 { focus-workspace 1; }
          Mod+2 { focus-workspace 2; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+5 { focus-workspace 5; }
          Mod+6 { focus-workspace 6; }
          Mod+7 { focus-workspace 7; }
          Mod+8 { focus-workspace 8; }
          Mod+9 { focus-workspace 9; }
          Mod+Ctrl+1 { move-column-to-workspace 1; }
          Mod+Ctrl+2 { move-column-to-workspace 2; }
          Mod+Ctrl+3 { move-column-to-workspace 3; }
          Mod+Ctrl+4 { move-column-to-workspace 4; }
          Mod+Ctrl+5 { move-column-to-workspace 5; }
          Mod+Ctrl+6 { move-column-to-workspace 6; }
          Mod+Ctrl+7 { move-column-to-workspace 7; }
          Mod+Ctrl+8 { move-column-to-workspace 8; }
          Mod+Ctrl+9 { move-column-to-workspace 9; }

          XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@"   "0.1+"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@"   "0.1-"; }
          XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute"   "@DEFAULT_AUDIO_SINK@"   "toggle"; }
          XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute"   "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
        }
      '';
    };
  };
}
