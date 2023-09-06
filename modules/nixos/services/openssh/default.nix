{ options, config, lib, pkgs, host ? "", format ? "", ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.services.openssh;
  user = config.users.users.${config.plusultra.user.name};
  user-id = builtins.toString user.uid;

  name = host;
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
