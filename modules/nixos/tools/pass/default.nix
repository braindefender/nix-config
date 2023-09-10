{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.pass;
in
{
  options.plusultra.tools.pass = with types; {
    enable = mkBoolOpt false "Enable pass, password-store?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        password-store = {
          enable = true;
        };
      };
    };
    environment.systemPackages = with pkgs; [ pass ];
  };
}
