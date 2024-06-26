{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.user;

in {
  options.plusultra.user = with types; {
    name = mkOpt str "brain" "The name to use for the user account.";
    fullName = mkOpt str "Nikita Shirokov" "The full name of the user.";
    email = mkOpt str "braindefender@gmail.com" "The email of the user.";
    initialPassword = mkOpt str "nixos" "The initial password of user account.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } (mdDoc "Extra options passed to `users.users.<name>`.");
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;

      inherit (cfg) name initialPassword;

      home = "/home/${cfg.name}";
      group = "users";

      # Arbitrary user ID to use for the user. Since I only
      # have a single user on my machines this won't ever collide.
      # However, if you add multiple users you'll need to change this
      # so each user has their own unique uid (or leave it out for the
      # system to select).
      uid = 1000;

      extraGroups = [ "wheel" ] ++ cfg.extraGroups;
    } // cfg.extraOptions;
  };
}
