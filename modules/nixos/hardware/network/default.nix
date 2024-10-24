{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.hardware.network;
in

{
  options.plusultra.hardware.network = with types; {
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
    ];

    services.strongswan = {
      enable = true;
      secrets = [ "ipsec.d/ipsec.nm-l2tp.secrets" ];
    };

    services.openssh.enable = true;

    networking = {
      networkmanager = {
        enable = true;
        enableStrongSwan = true;
      };

      hosts = { } // cfg.hosts;

      nameservers = [ "1.1.1.1" "8.8.8.8" ] ++ (cfg.dns or [ ]);
    };

    plusultra.system.home.extraOptions = {
      services.network-manager-applet.enable = true;
    };

    systemd.services.NetworkManager-wait-online.enable = false;
  };
}
