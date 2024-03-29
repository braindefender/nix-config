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
        # picom = enabled;
        # startx = enabled;
        # leftwm = enabled;
        # hlwm = enabled;
        # i3wm = enabled;

        ### Wayland Shit
        hyprland = enabled;
        # gnome = enabled;
        # sway = enabled;
      };

      apps = {
        # barrier = enabled;
        # chromium = enabled;
        discord = enabled;
        dunst = enabled;
        figma = enabled;
        firefox = enabled;
        flameshot = enabled;
        gimp = enabled;
        gparted = enabled;
        helix = enabled;
        kitty = enabled;
        # krusader = enabled;
        # moonlight = enabled;
        # obs-studio = enabled;
        obsidian = enabled;
        polybar = enabled;
        qbittorrent = enabled;
        rofi = enabled;
        telegram = enabled;
        vivaldi = enabled;
        vlc = enabled;
        vscode = enabled;
        watershot = enabled;
      };

      tools = {
        common = enabled;
        aliases = enabled;

        zsh = {
          enable = true;
          default = true;
        };

        bat = enabled;
        broot = enabled;
        direnv = enabled;
        eza = enabled;
        feh = enabled;
        fzf = enabled;
        git = enabled;
        lazygit = enabled;
        lf = enabled;
        joshuto = enabled;
        neovim = enabled;
        pass = enabled;
        starship = enabled;
        tealdeer = enabled;
        yt-dlp = enabled;
        zellij = enabled;
        zoxide = enabled;
      };

      services = {
        # acme = enabled;
        ollama = enabled;
        openssh = enabled;
        syncthing = enabled;
        vaultwarden = enabled;
      };
    };
  };
}
