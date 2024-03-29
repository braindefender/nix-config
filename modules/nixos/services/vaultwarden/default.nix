{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.services.vaultwarden;

  domain = config.networking.domain;
  fqdn = "warden.${domain}";
  address = "127.0.0.1";
  port = "8020";
in
{
  options.plusultra.services.vaultwarden = with types; {
    enable = mkBoolOpt false "Enable VaultWarden?";
  };

  config = mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;

      config = {
        TZ = "Asia/Novosibirsk";
        WEB_VAULT_ENABLED = true;
        ROCKET_ADDRESS = address;
        ROCKET_PORT = port;
        # DOMAIN = "https://${fqdn}";
      };
    };


    # services.nginx = {
    #   virtualHosts."${fqdn}" = {
    #     forceSSL = true;
    #     useACMEHost = domain;

    #     listen.port = 8000;

    #     locations."/" = {
    #       proxyPass = "http://${address}:${port}";
    #     };
    #   };
    # };
  };
}
