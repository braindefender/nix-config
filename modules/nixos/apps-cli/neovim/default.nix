{options, config, pkgs, lib, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.apps-cli.neovim;

in {
  options.plusultra.apps-cli.neovim = with types; {
    enable = mkBoolOpt false "Enable neovim?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      plusultra.neovim
    ];
    plusultra.home.extraOptions = {
      programs.zsh.shellAliases.vimdiff = "nvim -d"; 
      programs.bash.shellAliases.vimdiff = "nvim -d"; 
      programs.fish.shellAliases.vimdiff = "nvim -d"; 
      programs.nushell.shellAliases.vimdiff = "nvim -d"; 
    };
  };
}
