{options, config, lib, pkgs, ...}:

with lib;
with lib.plusultra;

let cfg = config.plusultra.system.keyring;

in {
  options.plusultra.system.keyring = with types; {
    enable = mkBoolOpt false "Enable GNOME Keyring?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ 
      gnome.gnome-keyring
      gnome.libgnome-keyring
    ];
  };
}
