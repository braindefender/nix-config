{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.system.gpg;

in {
  options.plusultra.system.gpg = with types; {
    enable = mkBoolOpt false "Enable GPG?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnupg
    ];

    plusultra.system.home.extraOptions = {
      programs = {
        gpg = {
          enable = true;
        };
      };
      services.gpg-agent = {
        enable = true;
        enableSshSupport = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
  };
}
