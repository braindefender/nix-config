{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.services.ollama;

in {
  options.plusultra.services.ollama = with types; {
    enable = mkBoolOpt false "Enable Ollama?";
  };

  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
    };
  };
}
