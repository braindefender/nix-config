{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.tools.exa;

in {
  options.plusultra.tools.exa = with types; {
    enable = mkBoolOpt false "Enable exa?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        exa = {
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
            ll = "exa -l";
            la = "exa -a";
            lt = "exa --tree";
            lla = "exa -la";
          };
        };

      };
    };
    environment.systemPackages = with pkgs; [ exa ];
  };
}
