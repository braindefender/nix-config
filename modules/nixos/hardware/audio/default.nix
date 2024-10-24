{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.hardware.audio;
in

{
  options.plusultra.hardware.audio = with types; {
    enable = mkBoolOpt false "Enable audio configuration?";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;

      alsa.enable = true;
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    hardware.pulseaudio.enable = mkForce false;

    environment.systemPackages = with pkgs; [
      pulsemixer
      pavucontrol
    ];

    plusultra.user.extraGroups = [ "audio" ];
  };
}
