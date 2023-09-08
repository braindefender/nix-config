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
            dust = "${lib.getExe du-dust}";
            hx = "helix";
            sudo = mkIf config.plusultra.system.doas.enable "doas";

            # Git
            g = "git";
            push = "git push";
            pull = "git pull";
            fetch = "git fetch";
            commit = "git add . and git commit -m";

            # NixOS
            cleanup = "doas nix-collect-garbage --delete-older-than 7d";
            bloat = "nix path-info -Sh /run/current-system";
          };
        };
      };
    };
  };
}
