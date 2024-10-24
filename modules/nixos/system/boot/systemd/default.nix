{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.system.boot.systemd-boot;
in

{
  options.plusultra.system.boot.systemd-boot = with types; {
    enable = mkBoolOpt false "Enable systemd-boot?";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot = {
        enable = true;
        editor = false; # for security reasons
        configurationLimit = 10;
      };

      timeout = 2;

      efi.canTouchEfiVariables = true;
    };
  };
}
