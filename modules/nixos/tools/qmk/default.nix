{ config, options, pkgs, lib, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.tools.qmk;

in
{
  options.plusultra.tools.qmk = with types; {
    enable = mkBoolOpt false "Enable QMK Keyboard Firmware?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ qmk ];
    services.udev.packages = with pkgs; [ qmk-udev-rules ];
  };
}

