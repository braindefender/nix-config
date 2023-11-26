{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps.rofi;

in {
  options.plusultra.apps.rofi = with types; {
    enable = mkBoolOpt false "Enable rofi?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ rofi ];

    plusultra.system.home.extraOptions = {
      programs.rofi = {
        enable = true;
        plugins = with pkgs; [ rofi-calc rofi-emoji ];
      };
    };
  };
}
