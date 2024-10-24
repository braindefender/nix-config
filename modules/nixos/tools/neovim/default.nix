{ config
, pkgs
, lib
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.neovim;
in

{
  options.plusultra.tools.neovim = with types; {
    enable = mkBoolOpt false "Enable neovim?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # plusultra.neovim
      neovim
    ];

    environment.variables = {
      EDITOR = "nvim";
    };

    plusultra.system.home.extraOptions = {
      home.sessionVariables = {
        EDITOR = "nvim";
      };
      programs.zsh.shellAliases.vimdiff = "nvim -d";
    };
  };
}
