{ options, config, lib, pkgs, host ? "", format ? "", ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.services.syncthing;
  git = "${pkgs.git}/bin/git";
  dataDir = "/data";

  # use this as versioning command
  # /run/current-system/sw/bin/syncthing-git-backup %FOLDER_PATH% %FILE_PATH%
  syncthing-git-backup = pkgs.writeShellScriptBin "syncthing-git-backup" ''
    set -eu

    path_folder="$1"
    path_file="$2"
    
    path_backup="${dataDir}/backup$path_folder"
    
    mkdir -p "$path_backup"

    if [ ! -d "$path_backup/.git" ]; then
      cd "$path_backup" && ${git} init
    fi

    path_output=`dirname "$path_backup/$path_file"`
    mkdir -p "$path_output"
    mv -f "$path_folder/$path_file" "$path_backup/$path_file"

    cd "$path_backup"
    ${git} add .
    ${git} commit -m "`date +'%Y-%m-%d %H:%M:%S'` - $path_file"
  '';
in
{
  options.plusultra.services.syncthing = with types; {
    enable = mkBoolOpt false "Enable SyncThing?";
  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = config.plusultra.user.name;

      overrideFolders = false;
      overrideDevices = false;

      guiAddress = "0.0.0.0:8384";

      dataDir = dataDir;
    };

    plusultra.user.extraGroups = [ "syncthing" ];

    environment.systemPackages = with pkgs; [ syncthing-git-backup ];
  };
}
