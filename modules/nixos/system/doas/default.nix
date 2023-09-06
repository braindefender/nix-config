{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.system.doas;

in {
  options.plusultra.system.doas = with types; {
    enable = mkBoolOpt false "Enable doas instead of sudo?";
  };

  config = mkIf cfg.enable {
    security.sudo.enable = false;

    security.doas = {
      enable = true;
      extraRules = [{
        users = [ config.plusultra.user.name ];
	noPass = true;
	keepEnv = true;
      }];
    };

    environment.shellAliases = { sudo = "doas"; };
  };
}
