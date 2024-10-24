{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.gnome;
  # gdmHome = config.users.users.gdm.home;
in

{
  options.plusultra.desktop.gnome = with types; {
    enable = mkBoolOpt false "Whether or not to use GNOME as the desktop environment.";
    wayland = mkBoolOpt true "Whether or not to use Wayland as the desktop compositor.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard
      gnome.gnome-tweaks
      gnome.nautilus-python
    ];

    environment.gnome.excludePackages = with pkgs.gnome; [
      pkgs.gnome-tour
      epiphany
      geary
      # gnome-font-viewer
      # gnome-system-monitor
      gnome-maps
    ];

    # Required for app indicators
    services.udev.packages = with pkgs; [ gnome3.gnome-settings-daemon ];

    services.xserver = {
      enable = true;

      displayManager.gdm = {
        enable = true;
        wayland = cfg.wayland;
      };

      desktopManager.gnome.enable = true;
    };

    programs.kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
  };
}
