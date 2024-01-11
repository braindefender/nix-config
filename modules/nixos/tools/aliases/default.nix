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
    dust = "${pkgs.du-dust}/bin/dust -X .git -X node_modules";
    grep = "${pkgs.gnugrep}/bin/grep --color='always'";

    # Git
    g = "git";
    gs = "git status";
    push = "git push";
    pull = "git pull";
    fetch = "git fetch";
    commit = "git commit -a -m";

    # NixOS
    cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
    bloat = "nix path-info -Sh /run/current-system";

    # ZFS
    zlist = "sudo zfs list | grep --invert-match 'rpool/root/'";
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
        nushell.shellAliases = aliases;
      };
    };
  };
}
