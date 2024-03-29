{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.tools.joshuto;

in {
  options.plusultra.tools.joshuto = with types; {
    enable = mkBoolOpt false "Enable joshuto?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ joshuto ];
  };
}
