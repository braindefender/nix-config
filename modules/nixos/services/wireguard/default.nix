{ options, config, lib, pkgs, host ? "", format ? "", ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.services.wireguard;
  username = config.plusultra.user.name;
in
{
  options.plusultra.services.wireguard = with types;
    {
      enable = mkBoolOpt false "Enable WireGuard?";
    };

  # note: not working on wayland

  config = mkIf cfg.enable {
    boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];

    systemd.network = {
      enable = true;

      netdevs = {
        "wg0" = {
          netdevConfig = {
            Kind = "wireguard";
            Name = "wg0";
            MTUBytes = 1280;
          };
          wireguardConfig = {
            PrivateKeyFile = "/run/keys/wireguard-privkey";
            ListenPort = 39957;
          };
          wireguardPeers = [
            {
              wireguardPeerConfig = {
                PublicKey = "vNn9m/x2gmwLAYgA+vEptxuKt25NXkAy6427m6j8LkQ=";
                AllowedIPs = [ "0.0.0.0/0" "::/0" ];
                Endpoint = "64.227.126.8:51825";
              };
            }
          ];
        };
      };

      networks.wg0 = {
        matchConfig.Name = "wg0";
        address = [
          "10.0.0.7/8"
          "fd00:00:00::7/8"
        ];
        DHCP = "no";
        dns = [
          "94.140.14.14"
          "94.140.15.15"
          "2a10:50c0::ad1:ff"
          "2a10:50c0::ad2:ff"
        ];
        gateway = [
          "10.0.0.1"
        ];
      };
    };
  };
}
