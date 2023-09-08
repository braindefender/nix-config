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
      killall
      unzip
      # file
      jq # CLI JSON processor
      # clac
      wget
      # TODO: make settings for shell
      ripgrep # recursive search for a regex in directory
      fd # simple, fast and user-friendly alternative to `find`
      du-dust # A more intuitive version of du written in Rust
    ];
  };
}
