{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.vivaldi;
in

{
  options.plusultra.apps.vivaldi = with types; {
    enable = mkBoolOpt false "Enable Vivaldi?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vivaldi ];
  };
}
