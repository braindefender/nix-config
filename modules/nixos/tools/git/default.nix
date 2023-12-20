{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.git;
  user = config.plusultra.user;
in
{
  options.plusultra.tools.git = with types; {
    enable = mkBoolOpt false "Enable Git? No, really?";
    userName = mkOpt str user.fullName "git config user.name";
    userEmail = mkOpt str user.email "git config user.email";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git ];

    plusultra.system.home.extraOptions = {
      programs.git = {
        enable = true;
        package = pkgs.gitFull;
        inherit (cfg) userName userEmail;
        extraConfig = {
          init = { defaultBranch = "master"; };
          pull = { rebase = true; };
          push = { autoSetupRemote = true; };
          credential.helper = "libsecret";
        };
      };
    };
  };
}
