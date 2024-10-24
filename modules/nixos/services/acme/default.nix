{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.services.acme;
  domain = config.networking.domain;
  # todo: check setup
in

{
  options.plusultra.services.acme = with types; {
    enable = mkBoolOpt false "Enable ACME?";
  };

  config = mkIf cfg.enable {
    security.acme = {
      acceptTerms = true;

      defaults = {
        email = config.plusultra.user.email;
        # use staging server for testing purpose. higher rate limits.
        server = "https://acme-staging-v02.api.letsencrypt.org/directory";
      };

      certs = {
        "${domain}" = {
          extraDomainNames = [ "*.${domain}" ];
          dnsProvider = "regru";
          group = "nginx";

          credentialFiles = {
            REGRU_USERNAME_FILE = "/home/brain/regru/username";
            REGRU_PASSWORD_FILE = "/home/brain/regru/password";
          };
        };
      };
    };

    services.nginx = {
      enable = true;

      recommendedTlsSettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
    };
  };
}
