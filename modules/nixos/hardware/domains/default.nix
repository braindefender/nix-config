{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.hardware.domains;
in
{
  options.plusultra.hardware.domains = with types; {
    enable = mkBoolOpt false "Enable braindefender.ru domain settings";
  };
  config = mkIf cfg.enable {
    networking.domain = "braindefender.ru";

    plusultra.hardware.network.dns = [ "ns1.reg.ru" "ns2.reg.ru" ];
  };
}
