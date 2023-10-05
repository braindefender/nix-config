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

    environment.systemPackages = with pkgs; [ networkmanager-l2tp ];

    # services.xl3tpd.enable = true;

    services.strongswan = {
      enable = true;
      secrets = [ "ipsec.d/ipsec.nm-l2tp.secrets" ];
    };

    networking = {
      networkmanager = {
        enable = true;
        enableStrongSwan = true;
      };

      firewall.checkReversePath = "loose";

      hosts = {
        ${localhost} = [ "local.test" ] ++ (cfg.hosts.${localhost} or [ ]);
      } // cfg.hosts;
    };

    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
