{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps-cli.yt-dlp;

in
{
  options.plusultra.apps-cli.yt-dlp = with types; {
    enable = mkBoolOpt false "Enable yt-dlp?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ yt-dlp ];
    plusultra.system.home.extraOptions = {
      programs.yt-dlp = {
        enable = true;

        settings = {
          embed-thumbnail = true;
        };
      };
    };
  };
}
