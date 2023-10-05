{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.suites.modeling;

in {
  options.plusultra.suites.modeling = with types; {
    enable = mkBoolOpt false "Enable modeling configuration?";
  };

  config = mkIf cfg.enable {
    plusultra = {
      apps = {
        blender = enabled;
        openscad = enabled;
      };
    };
  };
}
