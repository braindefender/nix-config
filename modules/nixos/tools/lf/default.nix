{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.tools.lf;

in
{
  options.plusultra.tools.lf = with types; {
    enable = mkBoolOpt false "Enable lf file manager?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      # Icons
      xdg.configFile."lf/icons".source = ./icons;

      programs.lf = {
        enable = true;

        settings = {
          preview = true;
          drawbox = true;
          ignorecase = true;
          icons = true;
        };

        commands = {
          dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
	  editor-open = ''$$EDITOR $f'';
	  mkdir = ''
            ''${{
	      printf "Directory name: "
	      read DIR
	      mkdir $DIR
	    }}
	  '';
        };

        keybindings = {
          d = "cut";
          D = "delete";
          c = "mkdir";
          "." = "set hidden!";
          "<enter>" = "open";

          do = "dragon-out";
          gh = "cd";
          "g/" = "/";

          V = ''''$${pkgs.bat}/bin/bat --paging=always --theme=catppuccin "$f"'';
        };


	extraConfig = 
	let
	  previewer = 
            pkgs.writeShellScriptBin "pv.sh" ''
            file=$1
            w=$2
            h=$3
            x=$4
            y=$5
        
            if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
              ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
              exit 1
            fi
        
            ${pkgs.pistol}/bin/pistol "$file"
          '';
          cleaner = pkgs.writeShellScriptBin "clean.sh" ''
            ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
          '';
        in
        ''
          set cleaner ${cleaner}/bin/clean.sh
          set previewer ${previewer}/bin/pv.sh
        '';
      };
    };

    environment.systemPackages = with pkgs; [ lf ];
  };
}
