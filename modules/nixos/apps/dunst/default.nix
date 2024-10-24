{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.dunst;
in

{
  options.plusultra.apps.dunst = with types; {
    enable = mkBoolOpt false "Enable dunst?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ dunst ];
  };
}
