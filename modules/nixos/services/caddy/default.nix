{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.services.caddy;
in

{
  options.plusultra.services.caddy = with types; {
    enable = mkBoolOpt false "Enable Caddy?";
  };

  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;

      virtualHosts."braindefender.ru" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:6167
        '';
      };
    };
  };
}
