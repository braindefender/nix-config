{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.chromium;
in
{
  options.plusultra.apps.chromium = with types; {
    enable = mkBoolOpt false "Enable Chromium?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ chromium ];

    plusultra.system.home.extraOptions = {
      programs.chromium = {
        enable = true;

        extensions = [ ];
      };
    };
  };
}
