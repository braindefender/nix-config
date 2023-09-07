{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.system.nix;

in {
  options.plusultra.system.nix = with types; {
    enable = mkBoolOpt true "Whether or not to manage nix configuration.";
    package = mkOpt package pkgs.nixUnstable "Which nix package to use.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ nix-index nixpkgs-fmt ];

    nix =
      let users = [ "root" config.plusultra.user.name ];
      in {
        package = cfg.package;

        settings = {
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

