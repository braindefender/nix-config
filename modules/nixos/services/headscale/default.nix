{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.services.headscale;

in {
  options.plusultra.services.headscale = with types; {
    enable = mkBoolOpt false "Enable Headscale?";
  };

  config = mkIf cfg.enable {
    services.headscale = {
      enable = true;
      address = "0.0.0.0";
      port = 8080;
      serverUrl = "https://${domain}";
    };
  };
}
