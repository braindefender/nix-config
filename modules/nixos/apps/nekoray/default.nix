{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.nekoray;
in

{
  options.plusultra.apps.nekoray = with types; {
    enable = mkBoolOpt false "Enable NekoRay VPN Client?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nekoray ];
  };
}
