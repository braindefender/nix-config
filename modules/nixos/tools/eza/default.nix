{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.tools.eza;

in {
  options.plusultra.tools.eza = with types; {
    enable = mkBoolOpt false "Enable eza?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        eza = {
          enable = true;
          icons = true;
          git = true;
          enableAliases = true;
          extraOptions = [
            "--group-directories-first"
            "--time-style long-iso"
            "--no-user"
          ];
        };
        nushell = {
          shellAliases = with pkgs; {
            # ls = "exa"; # turned of because of nushell great ls command
            ll = "eza -l";
            la = "eza -a";
            lt = "eza --tree";
            lla = "eza -la";
          };
        };

      };
    };
    environment.systemPackages = with pkgs; [ eza ];
  };
}
