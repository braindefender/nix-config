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
        barrier = enabled;
        chromium = enabled;
        discord = enabled;
        dunst = enabled;
        figma = enabled;
        firefox = enabled;
        flameshot = enabled;
        gimp = enabled;
        gparted = enabled;
        helix = enabled;
        kitty = enabled;
        krusader = enabled;
        moonlight = enabled;
        obs-studio = enabled;
        obsidian = enabled;
        polybar = enabled;
        qbittorrent = enabled;
        rofi = enabled;
        telegram = enabled;
        vscode = enabled;
        # watershot = enabled;
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
        feh = enabled;
        fzf = enabled;
        git = enabled;
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
      };
    };
  };
}
