{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.hardware.bluetooth;
in

{
  options.plusultra.hardware.bluetooth = with types; {
    enable = mkBoolOpt false "Enable Bluetooth?";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
  };
}
