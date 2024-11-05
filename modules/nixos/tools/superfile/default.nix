{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.superfile;
  config_superfile = builtins.readFile ./config_superfile.toml;
  config_superfile_hotkeys = builtins.readFile ./config_superfile_hotkeys.toml;
in

{
  options.plusultra.tools.superfile = with types; {
    enable = mkBoolOpt false "Enable superfile?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      superfile
      exiftool
    ];

    plusultra.system.home.file = {
      ".config/superfile/config.toml".text = config_superfile;
      ".config/superfile/hotkeys.toml".text = config_superfile_hotkeys;
    };
  };
}
