{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.hardware.networking;
  localhost = "127.0.0.1";
in
{
  options.plusultra.hardware.networking = with types; {
    enable = mkBoolOpt false "Enable Network Manager?";
    hosts = mkOpt attrs { }
      (mdDoc "An attribute set to merge with `networking.hosts`");
  };

  config = mkIf cfg.enable {
    plusultra.user.extraGroups = [ "networkmanager" ];

    networking = {
      networkmanager = {
        enable = true;
        dhcp = "internal";
      };

      hosts = {
        ${localhost} = [ "local.test" ] ++ (cfg.hosts.${localhost} or [ ]);
      } // cfg.hosts;
    };

    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
