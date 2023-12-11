{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.desktop.picom;
in
{
  options.plusultra.desktop.picom = with types; {
    enable = mkBoolOpt false "Enable picom composition manager?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ picom-next ];

    plusultra.system.home.extraOptions = {
      services.picom = {
        package = pkgs.picom-next;
        vSync = true;
      };
    };
  };
}
