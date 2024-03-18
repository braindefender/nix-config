{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.hardware.video;
in
{
  options.plusultra.hardware.video = with types; {
    enable = mkBoolOpt false "Enable Intel Video Drivers?";
  };

  config = mkIf cfg.enable {
    boot.initrd.kernelModules = [ "i915" ];
    boot.kernelParams = [ "i915.enable_guc=2" "i915.force_probe=a780" "i915.modeset=1" ];

    services.xserver.videoDrivers = [ "intel" ];

    hardware = {
      cpu.intel.updateMicrocode = true;

      opengl = {
        enable = true;
        driSupport = true;
        extraPackages = with pkgs;[
          intel-media-driver
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      linux-firmware
      libva-utils
      glibc
      mesa
    ];
  };
}
