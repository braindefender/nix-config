{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.niri;
  gdmHome = config.users.users.gdm.home;
in
{
  options.plusultra.desktop.niri = with types; {
    enable = mkBoolOpt false "Enable Niri Window Manager?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ];
  };
}
