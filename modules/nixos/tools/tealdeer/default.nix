{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.tools.tealdeer;

in
{
  options.plusultra.tools.tealdeer = with types; {
    enable = mkBoolOpt false "Enable Tealdeer?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        tealdeer = {
          enable = true;

          settings = {
            updates = {
              auto_update = true;
            };
          };
        };
      };
    };
    environment.systemPackages = with pkgs; [ tealdeer ];
  };
}
