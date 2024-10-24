{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.yazi;
  # note: deprecated. use joshuto instead
in

{
  options.plusultra.tools.yazi = with types; {
    enable = mkBoolOpt false "Enable yazi?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ffmpegthumbnailer
      unar
      jq
      poppler
      fd
      ripgrep
      fzf
    ];

    plusultra.system.home.extraOptions = {
      programs.yazi = {
        enable = true;
        enableZshIntegration = true;
        enableNushellIntegration = true;

        settings = { };
        keymap = { };
      };
    };
  };
}
