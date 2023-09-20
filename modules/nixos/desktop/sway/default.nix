{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.sway;
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };
in
{
  options.plusultra.desktop.sway = with types; {
    enable = mkBoolOpt false "Enable Sway Window Manager?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      alacritty
      dbus-sway-environment
      configure-gtk
      wayland
      xdg-utils
      glib
      dracula-theme
      gnome3.adwaita-icon-theme
      swaylock
      swayidle
      grim
      slurp
      wl-clipboard
      bemenu
      mako
      wdisplays
    ];

    services.dbus.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };

  };
}
