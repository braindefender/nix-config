{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let 
  cfg = config.plusultra.services.headscale;
  domain = "headscale.helix";
in {
  options.plusultra.services.headscale = with types; {
    enable = mkBoolOpt false "Enable Headscale?";
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = [ server_port ];
      allowedUDPPorts = [ server_port ];
    };
  
    services.headscale = {
      enable = true;

      address = "0.0.0.0";
      port = 9999;

      settings = {
        serverUrl = "http://192.168.0.140:9999";
      };
    };
  };
}
