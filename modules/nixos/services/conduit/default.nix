{ config
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.services.conduit;
in

{
  options.plusultra.services.conduit = with types; {
    enable = mkBoolOpt false "Enable Conduit?";
  };

  config = mkIf cfg.enable {
    services.matrix-conduit = {
      enable = true;

      settings.global = {
        server_name = "matrix.braindefender.ru";
        port = 6167;
      };
    };
  };
}
