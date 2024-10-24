{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.leftwm;
  script_xinitrc = builtins.readFile ./script_xinitrc.sh;
  config_leftwm = builtins.readFile ./config_leftwm.ron;
in

{
  options.plusultra.desktop.leftwm = with types; {
    enable = mkBoolOpt false "Enable leftwm window manager?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ leftwm ];

    plusultra.system.home.file = {
      ".xinitrc".text = script_xinitrc;
      ".config/leftwm/config.ron".text = config_leftwm;
    };
  };
}
