{ config, lib, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.hardware.keyboard;
in {
  options.plusultra.hardware.keyboard = with types; {
    enable = mkBoolOpt false "Whether or not to enable keyboard configuration.";
  };

  config = mkIf cfg.enable {
    plusultra = {
      tools.qmk = enabled;
      hardware.universal-layout = {
        enable = true;
        ortho = true;
      };
    };
  };
}
