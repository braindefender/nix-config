{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.system.boot.grub;

in {
  options.plusultra.system.boot.grub = with types; {
    enable = mkBoolOpt false "Enable GRUB bootloader?";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      grub = {
        enable = true;
	device = "/dev/sda"; # TODO: fix
	useOSProber = false;
	configurationLimit = 10;
      };

      timeout = 2;

      efi.canTouchEfiVariables = true;
    };
  };
}
