{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.tools.fzf;

in {
  options.plusultra.tools.fzf = with types; {
    enable = mkBoolOpt false "Enable FZF?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs = {
        fzf = {
          enable = true;

          enableBashIntegration = true;
          enableFishIntegration = true;
          enableZshIntegration = true;

          defaultCommand = "${pkgs.fd} --type f --strip-cwd-prefix";

          defaultOptions = [
            "--border"
            "--prompt 'λ '"
            "--pointer ''"
            "--marker ''"
          ];
        };
      };
    };
    environment.systemPackages = with pkgs; [ fzf ];
  };
}
