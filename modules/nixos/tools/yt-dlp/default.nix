{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.tools.yt-dlp;

in
{
  options.plusultra.tools.yt-dlp = with types; {
    enable = mkBoolOpt false "Enable yt-dlp?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ yt-dlp ];
    plusultra.system.home.extraOptions = {
      programs = {
        yt-dlp = {
          enable = true;

          settings = {
            embed-thumbnail = true;
          };
        };
        nushell.shellAliases = {
          ytv = "yt-dlp --format \"bv*+ba/b\"";
          yta = ''
            yt-dlp -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"
          '';
        };
      };
    };
  };
}
