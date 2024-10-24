{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.qbittorrent;
in

{
  options.plusultra.apps.qbittorrent = with types; {
    enable = mkBoolOpt false "Enable qBitTorrent?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ qbittorrent ];
  };
}
