{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let 
  cfg = config.plusultra.tools.git;
  user = config.plusultra.user;
in {
  options.plusultra.tools.git = with types; {
    enable = mkBoolOpt false "Whether or not to install and configure git.";
    userName = mkOpt str user.fullName "The name to configure git with.";
    userEmail = mkOpt str user.email "The email to configure git with.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ git ];

    plusultra.home.extraOptions = {
      programs.git = {
        enable = true;
	inherit (cfg) userName userEmail;
	extraConfig = {
	  init = { defaultBranch = "master"; };
	  pull = { rebase = true; };
	  push = { autoSetupRemote = true; };
	};
      };
    };
  };
}

