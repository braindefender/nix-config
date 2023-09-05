{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.suites.common;

in {
  options.plusultra.suites.common = with types; {
    enable = mkBoolOpt false "Whether or not to enable common configuration.";
  };

  config = mkIf cfg.enable {
    plusultra = {
      nix = enabled;
      
      hardware = {
        keyboard = enabled;
      };

      tools = {
        git = enabled;
      };

      desktop = {
        gnome = enabled;
      };

      apps-gui = {
        blender = enabled;
	discord = enabled;
	firefox = enabled;
	gparted = enabled;
	obsidian = enabled;
	obs-studio = enabled;
	telegram = enabled;
      };

      apps-cli = {
        helix = enabled;
        neovim = enabled;
      };
    };
  };
}
