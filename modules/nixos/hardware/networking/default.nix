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
    dns = mkOpt (listOf str) [ ] "Custom DNS Server list";
  };

  config = mkIf cfg.enable {
    plusultra.user.extraGroups = [ "networkmanager" ];

    environment.systemPackages = with pkgs; [
      networkmanager
      networkmanager-l2tp
      networkmanager-openvpn
      networkmanager_strongswan
      networkmanagerapplet
      gnome.networkmanager-l2tp
      gnome.networkmanager-openvpn
    ];

    services.strongswan = {
      enable = true;
      secrets = [ "ipsec.d/ipsec.nm-l2tp.secrets" ];
    };

    networking = {
      domain = "braindefender.ru";

      networkmanager = {
        enable = true;
        enableStrongSwan = true;
      };

      firewall = {
        # отключено т.к. хост используется для локальной разработки
        # allowedTCPPorts = [ 22 80 443 ];
        # checkReversePath = "loose";
      };

      hosts = { localhost = [ localhost ]; } // cfg.hosts;

      nameservers = [ "1.1.1.1" "8.8.8.8" ] ++ (cfg.dns or [ ]);
    };

    plusultra.hardware.networking.dns = [ "ns1.reg.ru" "ns2.reg.ru" ];

    plusultra.system.home.extraOptions = {
      services.network-manager-applet.enable = true;
    };

    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
