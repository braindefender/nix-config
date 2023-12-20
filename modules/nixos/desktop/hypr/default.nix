{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.hypr;

  execute = ''
    exec-once=${pkgs.waybar}/bin/waybar
    exec-once=${pkgs.networkmanagerapplet}/bin/nm-applet
  '';

  bindings = ''
    bindm = SUPER, mouse:272, movewindow
    bindm = SUPER, mouse:273, resizewindow

    bind = SUPER,left,movefocus,l
    bind = SUPER,down,movefocus,d
    bind = SUPER,up,movefocus,u
    bind = SUPER,right,movefocus,r

    bindl=CTRL_SUPER,left,workspace,-1
    bindl=CTRL_SUPER,right,workspace,+1

    bind = SUPERSHIFT,left,movetoworkspace,-1
    bind = SUPERSHIFT,right,movetoworkspace,+1

    bind = SUPER,Return,exec,${pkgs.kitty}/bin/kitty
    bind = SUPER,Escape,exit,
    bind = SUPER,Q,killactive,
    bind = SUPER,L,exec,${pkgs.swaylock}/bin/swaylock
    bind = SUPER,E,exec,${pkgs.pcmanfm}/bin/pcmanfm
    bind = SUPER,H,togglefloating,
    bind = SUPER,Space,exec,${pkgs.wofi}/bin/wofi --show drun
    bind = SUPER,F,fullscreen,
    bind = SUPER,R,togglesplit,
    bind = SUPERSHIFT,F,forcerendererreload,
    bind = SUPERSHIFT,W,exec,${pkgs.waybar}/bin/waybar
    bind = SUPERSHIFT,R,exec,${pkgs.hyprland}/bin/hyprctl reload
  '';

  windowRules = ''
    windowrule = float,title:^(Volume Control)$
    windowrule = float,title:^(Picture-in-Picture)$
    windowrule = pin,title:^(Picture-in-Picture)$
    windowrule = move 75% 75% ,title:^(Picture-in-Picture)$
    windowrule = size 24% 24% ,title:^(Picture-in-Picture)$
    windowrule = float,title:^(Media viewer)$
    windowrulev2 = float,class:^(code)$,title:^(Open File)$
    windowrulev2 = float,class:^(virt-manager)$
  '';

  hyprlandConf = ''
            general {
              border_size = 2
              gaps_in = 4
              gaps_out = 8
              layout = master
            }

            decoration {
              rounding = 8
              fullscreen_opacity = 1
              inactive_opacity = 0.9
              active_opacity = 1
              drop_shadow = false
              blur {
                enabled = true
        	      new_optimizations = true
              }
            }

            animations {
              enabled = true

              bezier = myBezier, 0.05, 0.9, 0.1, 1.05

              animation = windows, 1, 7, myBezier
              animation = windowsOut, 1, 7, default, popin 80%
              animation = border, 1, 10, default
              animation = borderangle, 1, 8, default
              animation = fade, 1, 7, default
              animation = workspaces, 1, 6, default
            }

            input {
              sensitivity = 0
              follow_mouse = 2
              repeat_delay = 250
              accel_profile = flat
              numlock_by_default = 1
              kb_layout = universalLayoutOrtho
              kb_file = ${pkgs.xkeyboard_config.outPath}/share/X11/xkb/symbols/universalLayoutOrtho
            }

            dwindle {
              pseudotile = true
              preserve_split = true
            }

            master {
              new_is_master = false
              mfact = 0.66
            }

            monitor=,3440x1440@120,0x0,1
    	env=WLR_DRM_DEVICES,/dev/dri/card0

            ${execute}
            ${bindings}
            ${windowRules}
  '';

in
{
  options.plusultra.desktop.hypr = with types; {
    enable = mkBoolOpt false "Enable Hyprland?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs.zsh.loginExtra = ''
        if ((not 'DISPLAY' in $env); (tty) == "/dev/tty1") {
          Hyprland
        }
      '';
    };

    environment = {
      sessionVariables = {
        GDK_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        WLR_NO_HARDWARE_CURSORS = "1";
        WLR_DRM_DEVICES = "/dev/dri/card0";
        WLR_RENDER_DRM_DEVICES = "/dev/dri/renderD128";
      };

      variables = {
        XDG_CURRENT_DESKTOP = "Hyprland";
        XDG_SESSION_DESKTOP = "Hyprland";
        XDG_SESSION_TYPE = "wayland";
      };

      systemPackages = with pkgs; [
        hyprland
        swaylock
        wlr-randr
        wl-clipboard
        swww
        slurp
        grim
        swappy
      ];
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      enableNvidiaPatches = lib.mkDefault false;
    };

    programs.waybar.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };

    plusultra.system.home.extraOptions = {
      xdg.configFile."hypr/hyprland.conf".text = hyprlandConf;
    };
  };
}
