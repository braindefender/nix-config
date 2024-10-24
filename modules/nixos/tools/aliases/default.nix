{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.aliases;

  nrs = pkgs.writeShellScriptBin "nrs" ''
    sudo nixos-rebuild switch --flake .#helix
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

    lg = "lazygit";
    lf = "joshuto";

    # NixOS
    cleanup = "sudo nix-collect-garbage --delete-older-than 7d";
    bloat = "nix path-info -Sh /run/current-system";

    # ZFS
    zlist = "sudo zfs list | grep --invert-match 'vpool/root/'";
    zsnap = "sudo zfs list -t snapshot | grep --invert-match 'vpool/root/'";
  };
in
{
  options.plusultra.tools.aliases = with types; {
    enable = mkBoolOpt false "Enable shell aliases?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ nrs ];

    plusultra.system.home.extraOptions = {
      programs.zsh.shellAliases = aliases;
    };
  };
}
