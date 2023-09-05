{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.system.locale;

in {
  options.plusultra.system.locale = with types; {
    enable = mkBoolOpt false "Enable System Locale configuration?";
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = "en_US.UTF-8";

      extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };
  };
}
