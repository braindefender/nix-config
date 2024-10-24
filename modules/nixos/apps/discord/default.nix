{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.discord;
in

{
  options.plusultra.apps.discord = with types; {
    enable = mkBoolOpt false "Enable Discord?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ discord ];
  };
}
