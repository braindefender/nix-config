{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.hardware.audio;

in {
  options.plusultra.hardware.audio = with types; {
    enable = mkBoolOpt false "Enable audio configuration?";
    extraPackages = mkOpt (listOf package) with pkgs; [
      qjackctl
      easyeffects
    ] "Additional packages to install.";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      jack.enable = true;

      wireplumber.enable = true;
    };

    hardware.pulseaudio.enable = mkForce false;

    environment.systemPackages = with pkgs; [ 
      pulsemixer
      pavucontrol
    ] ++ cfg.extra-packages;

    plusultra.user.extraGroups = [ "audio" ];
  };
}
