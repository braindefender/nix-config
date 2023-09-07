{ options, config, pkgs, lib, inputs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.system.home;

in {
  options.plusultra.system.home = with types; {
    file = mkOpt attrs { } (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile = mkOpt attrs { } (mdDoc "A set of files to be managed by home-manager's `xdg.configFile`.");
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = {
    plusultra.system.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.plusultra.system.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.plusultra.system.home.configFile;
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      users.${config.plusultra.user.name} =
        mkAliasDefinitions options.plusultra.system.home.extraOptions;
    };
  };
}
