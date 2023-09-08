{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.shell.common;

in {
  options.plusultra.shell.common = with types; {
    enable = mkBoolOpt false "Enable common shell configuration?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      vim # Best editor ever
      fzf # CLI fuzzy-finder
      killall
      unzip
      # file
      jq # CLI JSON processor
      # clac
      wget
      # TODO: move to Home Manager
      zoxide # a smarter cd command
      # TODO: make settings for shell
      exa # modern replacement for ls
      ripgrep # recursive search for a regex in directory
      fd # simple, fast and user-friendly alternative to `find`
      du-dust # A more intuitive version of du written in Rust
    ];
  };
}
