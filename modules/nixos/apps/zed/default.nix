{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.zed;
in

{
  options.plusultra.apps.zed = with types; {
    enable = mkBoolOpt false "Enable Zed Editor?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zed-editor ];
  };
}
