{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let 
  cfg = config.plusultra.tools.yazi;
in {
  options.plusultra.tools.yazi = with types; {
    enable = mkBoolOpt false "Enable yazi?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ffmpegthumbnailer # Video thumbnails
      unar    # Archive preview
      jq      # JSON preview
      poppler # PDF preview
      fd      # File searching
      ripgrep # File content searching
      fzf     # Fuzzy-find navigation
    ];
    
    plusultra.system.home.extraOptions = {
      programs.yazi = {
        enable = true;

        enableNushellIntegration = true;
        enableZshIntegration = true;

        settings = {};

        keymap = {};
      };
    };
  };
}
