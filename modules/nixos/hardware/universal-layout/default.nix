{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.hardware.universal-layout;

in
{
  options.plusultra.hardware.universal-layout = with types; {
      enable = mkBoolOpt false "Whether to enable Universal Layout.";
      normal = mkBoolOpt false "Whether to enable Normal version.";
      ortho = mkBoolOpt false "Whether to enable Ortho version.";
      defaultLayout = mkOption {
        type = types.enum ["universalLayoutNormal" "universalLayoutOrtho"];
	default = "universalLayoutNormal";
	example = "universalLayoutOrtho";
	description = mkDoc "Which layout will be set as default.";
      };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      # TODO: layout is unaccessible on build time. needs to fix
      # layout = cfg.defaultLayout;

      extraLayouts = {
        universalLayoutNormal = mkIf cfg.normal {
	  description = "Universal Layout Normal";
	  languages = ["eng"];
	  symbolsFile = ./universalLayoutNormal;
	};

        universalLayoutOrtho = mkIf cfg.ortho {
	  description = "Universal Layout Ortho";
	  languages = ["eng"];
	  symbolsFile = ./universalLayoutOrtho;
	};
      };
    };
  };
}
