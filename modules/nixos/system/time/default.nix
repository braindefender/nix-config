{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.system.time;

in {
  options.plusultra.system.time = with types; {
    enable = mkBoolOpt false "Enable Time Zone configuration?";
  };

  config = mkIf cfg.enable {
    time.timeZone = "Asia/Novosibirsk";
  };
}
