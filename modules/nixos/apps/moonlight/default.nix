{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.moonlight;
in

{
  options.plusultra.apps.moonlight = with types; {
    enable = mkBoolOpt false "Enable Moonlight?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      moonlight-qt
      glibc
      intel-media-driver
      vaapiVdpau
    ];
  };
}
