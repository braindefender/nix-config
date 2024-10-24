{ config
, pkgs
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.system.nix;
  users = [ "root" config.plusultra.user.name ];
in

{
  options.plusultra.system.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nixVersions.latest "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    system.stateVersion = "23.05";

    environment.systemPackages = with pkgs; [
      nixd # language-server
      nix-tree # tree-like nix store exploration
      nix-index
      nixpkgs-fmt
    ];

    environment.variables = {
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";
    };

    nix = {
      package = cfg.package;

      settings = {
        cores = 4;
        experimental-features = [ "nix-command" "flakes" ];
        http-connections = 50;
        warn-dirty = false;
        log-lines = 50;
        sandbox = "relaxed";
        auto-optimise-store = true;
        trusted-users = users;
        allowed-users = users;
      };

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
    };
  };
}
