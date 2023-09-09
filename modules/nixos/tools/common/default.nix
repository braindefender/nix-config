{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.tools.common;

in {
  options.plusultra.tools.common = with types; {
    enable = mkBoolOpt false "Enable common shell tools?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim # Best editor ever
      # File Management
      unzip

      ### Shell Utils
      # TODO: make settings for shell
      killall
      jq # CLI JSON processor
      fd # simple, fast and user-friendly alternative to `find`
      ripgrep # recursive search for a regex in directory
      rsync # Fast and versatile file copying tool for remote and local files
      curl # CLI for transfer data over URL
      wget # almost the same as curl
      clac # stack-based calculator
      imagemagick # raster and vector image editor and converter
      ffmpeg-full # bunch of codecs and converter utilities

      ### Shell Apps
      du-dust # A more intuitive version of du written in Rust
      btop # Resource monitor

      ### Hardware Utils
      usbutils
      pciutils
      smartmontools
      wirelesstools
    ];
  };
}
