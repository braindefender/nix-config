{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.suites.common;

in {
  options.plusultra.suites.common = with types; {
    enable = mkBoolOpt false "Enable common configuration?";
  };

  config = mkIf cfg.enable {
    plusultra = {
      hardware = {
        audio = enabled;
        keyboard = enabled;
        networking = enabled;
      };

      system = {
        doas = enabled;
        fonts = enabled;
        keyring = enabled;
        locale = enabled;
        nix = enabled;
        time = enabled;
      };

      services = {
        openssh = enabled;
      };

      shell = {
        common = enabled;
        nushell = {
          enable = true;
          default = true;
        };
      };

      tools = {
        git = enabled;
        fzf = enabled;
      };

      desktop = {
        gnome = enabled;
      };

      apps-gui = {
        # blender = enabled;
        # discord = enabled;
        firefox = enabled;
        gparted = enabled;
        kitty = enabled;
        # obsidian = enabled;
        # obs-studio = enabled;
        telegram = enabled;
        vscode = enabled;
      };

      apps-cli = {
        helix = enabled;
        neovim = enabled;
        starship = enabled;
      };
    };
  };
}
