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

    networking.firewall.enable = false;

    environment.systemPackages = with pkgs; [ dbeaver ];
  };
}
