{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.helix;
  config_helix = builtins.readFile ./config_helix.toml;
in

{
  options.plusultra.apps.helix = with types;{
    enable = mkBoolOpt false "Enable Helix Editor?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ helix ];

    plusultra.system.home.extraOptions = {
      xdg.configFile."helix/config.toml".text = config_helix;
    };
  };
}
