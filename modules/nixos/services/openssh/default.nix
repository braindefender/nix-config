{ config
, lib
, format ? ""
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.services.openssh;
in

{
  options.plusultra.services.openssh = with types; {
    enable = mkBoolOpt false "Enable OpenSSH configuration?";
    port = mkOpt port 2222 "The port to listen on (in addition to 22).";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;

      settings = {
        PermitRootLogin = if format == "install-iso" then "yes" else "no";
        PasswordAuthentication = true;
      };

      ports = [ 22 cfg.port ];
    };
  };
}
