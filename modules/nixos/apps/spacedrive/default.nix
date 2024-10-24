{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.spacedrive;
in

{
  options.plusultra.apps.spacedrive = with types; {
    enable = mkBoolOpt false "Enable SpaceDrive?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ spacedrive ];
  };
}
