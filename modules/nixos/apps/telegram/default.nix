{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.telegram;
in

{
  options.plusultra.apps.telegram = with types; {
    enable = mkBoolOpt false "Enable Telegram Desktop?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ telegram-desktop ];
  };
}
