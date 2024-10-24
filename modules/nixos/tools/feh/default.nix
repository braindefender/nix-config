{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.feh;
in

{
  options.plusultra.tools.feh = with types; {
    enable = mkBoolOpt false "Enable FEH Image Viewer?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ feh ];
  };
}
