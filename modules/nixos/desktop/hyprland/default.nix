{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.hyprland;

  script_startup = pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.swww}/bin/swww init &

    sleep 1

    ${pkgs.swww}/bin/swww img "${pkgs.hyprland}/share/hyprland/wall2.png" &
  '';
in
{
  options.plusultra.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland window manager?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs.zsh.loginExtra = ''
        if [ -z "''${DISPLAY}" ] && [ $(tty) = "/dev/tty1" ]; then
          dbus-run-session Hyprland
        fi
      '';
    };

    environment.systemPackages = with pkgs; [ swww wl-clipboard ];

    plusultra.system.home.extraOptions = {

      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          exec-once = [
            ''${script_startup}/bin/start''
            ''nm-applet --indicator''
          ];

          "$mod" = "SUPER";

          bind = [
            "$mod, up,    movefocus, u"
            "$mod, down,  movefocus, d"
            "$mod, left,  movefocus, l"
            "$mod, right, movefocus, r"

            "$mod CTRL, left,  workspace, -1"
            "$mod CTRL, right, workspace, +1"

            "$mod CTRL SHIFT, left,  movetoworkspace, -1"
            "$mod CTRL SHIFT, right, movetoworkspace, +1"

            "$mod, Space, exec, ${pkgs.wofi}/bin/wofi --show drun"
            "$mod, Return, exec, ${pkgs.kitty}/bin/kitty"
            "$mod, Escape, exit"
            "$mod, Q, killactive"
            "$mod, H, togglefloating"
            "$mod, R, togglesplit"
            "$mod, F, fullscreen"
            "$mod SHIFT, F, forcerendererreload"
            "$mod SHIFT, R, exec, ${pkgs.hyprland}/bin/hyprctl reload"
            ", Print, exec, ${pkgs.watershot}/bin/watershot"
          ];

          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
            "$mod ALT, mouse:272, resizewindow"
          ];

          input = {
            follow_mouse = 1; # https://wiki.hyprland.org/Configuring/Variables/#follow-mouse-cursor
            repeat_delay = 250;
            numlock_by_default = 1;
            kb_layout = "universalLayoutOrtho";
            kb_file = "${pkgs.xkeyboard_config.outPath}/share/X11/xkb/symbols/universalLayoutOrtho";
          };

          general = {
            border_size = 2;
            gaps_in = 4;
            gaps_out = 8;
            layout = "master";
          };

          master = {
            new_is_master = false;
            mfact = 0.66;
          };

          animations = {
            enabled = false;
          };

          decoration = {
            rounding = 8;
            fullscreen_opacity = 1;
            inactive_opacity = 0.9;
            active_opacity = 1;
            drop_shadow = false;
          };

          monitor = "HDMI-A-1, 3440x1440@100, auto, 1";

          windowrulev2 = [
            "float, class:^(code)$, title:^(Open File)$"
            "float, class:^(virt-manager)$"
          ];
        };
      };
    };

  };
}
