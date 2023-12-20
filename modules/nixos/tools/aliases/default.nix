{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.aliases;

  home = config.users.users.${config.plusultra.user.name}.home;
  flake_path = "${home}/.setup";

  nrs = pkgs.writeShellScriptBin "nrs" ''
    git -C ${flake_path} add --all
    sudo nixos-rebuild switch --flake "${flake_path}#terra"
  '';

  aliases = {
    q = "exit";
    c = "clear";
    v = "nvim";
    dust = "du-dust";

    # Git
    g = "git";
    push = "git push";
    pull = "git pull";
    fetch = "git fetch";
    commit = "git add .; git commit -m";

    # NixOS
    cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
    bloat = "nix path-info -Sh /run/current-system";
  };
in
{
  options.plusultra.tools.aliases = with types; {
    enable = mkBoolOpt false "Enable shell aliases?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nrs
    ];

    plusultra.system.home.extraOptions = {
      programs = {
        bash.shellAliases = aliases;
        fish.shellAliases = aliases;
        zsh.shellAliases = aliases;
      };
    };
  };
}
