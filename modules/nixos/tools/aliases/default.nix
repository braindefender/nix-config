{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.aliases;
  aliases = {
    q = "exit";
    c = "clear";
    v = "nvim";
    hx = "helix";
    dust = "du-dust";

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
in
{
  options.plusultra.tools.aliases = with types; {
    enable = mkBoolOpt false "Enable shell aliases?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        bash.shellAliases = aliases;
        fish.shellAliases = aliases;
        zsh.shellAliases = aliases;
        nushell.shellAliases = aliases;
      };
    };
  };
}
