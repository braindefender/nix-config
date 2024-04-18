{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.teams;
in

{
  options.plusultra.apps.teams = with types; {
    enable = mkBoolOpt false "Enable Microsoft Teams?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs.plusultra; [ microsoft-teams-vivaldi ];
  };
}
