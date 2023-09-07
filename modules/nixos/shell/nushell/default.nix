{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.shell.nushell;
  nushell_config = builtins.readFile ./nushell.nu;
  nushell_git_completions = builtins.readFile ./git-completions.nu;
  nushell_combined = builtins.concatStringsSep "\n" [
    nushell_config
    nushell_git_completions
  ];
in
{
  options.plusultra.shell.nushell = with types; {
    enable = mkBoolOpt false "Enable Nushell?";
    default = mkBoolOpt false "Set Nushell as default shell?";
  };

  config = mkIf cfg.enable {
    plusultra.user.extraOptions = mkIf cfg.default {
      shell = pkgs.nushell;
    };
    plusultra.system.home.extraOptions = {
      programs = {
        nushell = {
          enable = true;

          configFile.text = nushell_combined;

          shellAliases = with pkgs; {
            q = "exit";
            c = "clear";
            m = "mkdir";
            v = "${lib.getExe neovim}";
            cat = "${lib.getExe bat} -p";
            dust = "${lib.getExe du-dust}";
            hx = "helix";

            # Exa instead of ls
            l = "${lib.getExe exa} -l --group-directories-first --time-style long-iso --no-user --icons";
            ll = "${lib.getExe exa} -la --group-directories-first --time-style long-iso --no-user --icons";
            la = "${lib.getExe exa} -la --group-directories-first --time-style long-iso --no-user --icons";
            tree = "${lib.getExe exa} --tree --icons --level=2";
            treee = "${lib.getExe exa} --tree --icons --level=3";

            # Git
            g = "git";
            push = "git push";
            pull = "git pull";
            fetch = "git fetch";
            commit = "git add . and git commit -m";

            # YouTube (download video and/or audio)
            ytv = "${lib.getExe yt-dlp} --format \"bv*+ba/b\"";
            yta = ''
              ${lib.getExe yt-dlp} -x --continue --add-metadata --embed-thumbnail --audio-format mp3 --audio-quality 0 --metadata-from-title="%(artist)s - %(title)s" --prefer-ffmpeg -o "%(title)s.%(ext)s"
            '';

            # NixOS
            cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
            bloat = "nix path-info -Sh /run/current-system";
          };
        };
      };
    };
  };
}
