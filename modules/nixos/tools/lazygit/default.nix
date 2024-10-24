{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.lazygit;
in

{
  options.plusultra.tools.lazygit = with types; {
    enable = mkBoolOpt false "Enable LazyGit?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ lazygit ];
  };
}
