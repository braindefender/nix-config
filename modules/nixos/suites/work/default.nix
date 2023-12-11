{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.suites.work;

in {
  options.plusultra.suites.work = with types; {
    enable = mkBoolOpt false "Enable work configuration?";
  };

  config = mkIf cfg.enable {
    plusultra = {
      apps = {
        teams = enabled;
      };
    };

    # networking.extraHosts = ''
    #   172.16.255.255  hrdt.local
    # '';

    environment.systemPackages = with pkgs; [ dbeaver ];
  };
}
