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
        virtualisation = enabled;
      };

      system = {
        # doas = enabled; # too much pain
        fonts = enabled;
        gpg = enabled;
        keyring = enabled;
        locale = enabled;
        nix = enabled;
        time = enabled;
      };

      desktop = {
        gtk = enabled;

        ### X Window System
        startx = enabled;
        leftwm = enabled;
        # i3wm = enabled;

        ### Wayland Shit
        # hypr = enabled;
        # gnome = enabled;
        # sway = enabled;
      };

      apps = {
        discord = enabled;
        firefox = enabled;
        chromium = enabled;
        gimp = enabled;
        gparted = enabled;
        kitty = enabled;
        krusader = enabled;
        moonlight = enabled;
        obsidian = enabled;
        obs-studio = enabled;
        qbittorrent = enabled;
        rofi = enabled;
        telegram = enabled;
        vscode = enabled;
        watershot = enabled;
      };

      tools = {
        common = enabled;
        aliases = enabled;

        nushell = {
          enable = true;
          default = true;
        };

        bat = enabled;
        direnv = enabled;
        eza = enabled;
        fzf = enabled;
        git = enabled;
        helix = enabled;
        lf = enabled;
        neovim = enabled;
        pass = enabled;
        starship = enabled;
        tealdeer = enabled;
        yt-dlp = enabled;
        zoxide = enabled;
      };

      services = {
        openssh = enabled;
        flameshot = enabled;
      };
    };
  };
}
