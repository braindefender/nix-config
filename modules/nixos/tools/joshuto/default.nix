{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let 
  cfg = config.plusultra.tools.joshuto;
in {
  options.plusultra.tools.joshuto = with types; {
    enable = mkBoolOpt false "Enable joshuto?";
  };

  config = mkIf cfg.enable {
    plusultra.system.home.extraOptions = {
      programs.joshuto = {
        enable = true;

        settings = {
          # defaults
          numbered_command = false;

          # mouse_support = true;
          focus_on_create = true;
          use_trash = true;
          watch_files = true;
          xdg_open = false;
          xdg_open_fork = false;
          case_insensitive_ext = false;

          # override
          mouse_support = false;
         
          display = {
            # defaults
            mode = "default";
            automatically_count_files = true;
            collapse_preview = false;
            column_ratio = [1 4 4];
            scroll_offset = 6;
            # show_borders = true;
            show_hidden = false;
            # show_icons = false;
            line_number_style = "none";
            linemode = "size";
            # override
            show_icons = true;
            show_borders = false;

            sort = {
              # defaults
              sort_method = "natural";
              case_sensitive = false;
              directories_first = true;
              reverse = false;
              # override
            };
          };

          preview = {
            # defaults
            # max_preview_size = 2097152; # 2 MiB
            preview_script = "~/.config/joshuto/preview_file.sh";
            # override
            max_preview_size = 3354432; # 32 MiB
          };
          
          search = {
            # defaults
            # string_case_sensitivity = "insensitive";
            # glob_case_sensitivity = "sensitive";
            regex_case_sensitivity = "sensitive";
            # fzf_case_sensitivity = "insensitive";
            # override
            string_case_sensitivity = "smart";
            glob_case_sensitivity = "smart";
            fzf_case_sensitivity = "smart";
          };

          tab = {
            # defaults
            home_page = "home";
            # override
          };
        };

        keymap = {
          default_view = {
            
            keymap = [
              { keys = ["?"]; commands = ["help"]; }

              { keys = ["escape"]; commands = ["escape"]; }

              { keys = ["t" "t"]; commands = ["new_tab"]; }
              { keys = ["t" "i"]; commands = ["new_tab --cursor"]; }
              { keys = ["t" "o"]; commands = ["new_tab --current"]; }
              { keys = ["t" "c"]; commands = ["close_tab"]; }
              { keys = ["q"]; commands = ["close_tab"]; }
              { keys = ["Q"]; commands = ["quit --output-current-directory"]; }

              { keys = ["R"]; commands = ["reload_dirlist"]; }
              { keys = ["h"]; commands = ["toggle_hidden"]; }
              { keys = ["\t"]; commands = ["tab_switch 1"]; }
              { keys = ["backtab"]; commands = ["tab_switch -1"]; }

              { keys = ["1"]; commands = ["numbered_command 1"]; }
              { keys = ["2"]; commands = ["numbered_command 2"]; }
              { keys = ["3"]; commands = ["numbered_command 3"]; }
              { keys = ["4"]; commands = ["numbered_command 4"]; }
              { keys = ["5"]; commands = ["numbered_command 5"]; }
              { keys = ["6"]; commands = ["numbered_command 6"]; }
              { keys = ["7"]; commands = ["numbered_command 7"]; }
              { keys = ["8"]; commands = ["numbered_command 8"]; }
              { keys = ["9"]; commands = ["numbered_command 9"]; }

              { keys = ["\n"]; commands = ["open"]; }

              { keys = ["arrow_left"]; commands = ["cd .."]; }
              { keys = ["j"]; commands = ["cd .."]; }
              { keys = ["arrow_down"]; commands = ["cursor_move_down"]; }
              { keys = ["k"]; commands = ["cursor_move_down"]; }
              { keys = ["arrow_up"]; commands = ["cursor_move_up"]; }
              { keys = ["l"]; commands = ["cursor_move_up"]; }
              { keys = ["arrow_right"]; commands = ["open"]; }
              { keys = ["~"]; commands = ["open"]; }

              { keys = ["home"]; commands = ["cursor_move_home"]; }
              { keys = ["end"]; commands = ["cursor_move_end"]; }
              { keys = ["page_up"]; commands = ["cursor_move_page_up"]; }
              { keys = ["page_down"]; commands = ["cursor_move_page_down"]; }
              { keys = ["ctrl+u"]; commands = ["cursor_move_page_up 0.5"]; }
              { keys = ["ctrl+d"]; commands = ["cursor_move_page_down 0.5"]; }
              { keys = ["ctrl+b"]; commands = ["cursor_move_page_up"]; }
              { keys = ["ctrl+f"]; commands = ["cursor_move_page_down"]; }

              { keys = ["g" "g"]; commands = ["cursor_move_home"]; }
              { keys = ["G"]; commands = ["cursor_move_end"]; }
              { keys = ["r"]; commands = ["open_with"]; }

              { keys = ["["]; commands = ["parent_cursor_move_up"]; }
              { keys = ["]"]; commands = ["parent_cursor_move_down"]; }

              { keys = ["c" "d"]; commands = [":cd "]; }
              { keys = ["c" "z"]; commands = ["zi"]; }

              { keys = ["d" "d"]; commands = ["cut_files"]; }
              { keys = ["y" "y"]; commands = ["copy_files"]; }
              { keys = ["y" "n"]; commands = ["copy_filename"]; }
              { keys = ["y" "."]; commands = ["copy_filename_without_extension"]; }
              { keys = ["y" "p"]; commands = ["copy_filepath"]; }
              { keys = ["y" "a"]; commands = ["copy_filepath --all-selected=true"]; }
              { keys = ["y" "d"]; commands = ["copy_dirpath"]; }

              { keys = ["p" "l"]; commands = ["symlink_files --relative=false"]; }
              { keys = ["p" "L"]; commands = ["symlink_files --relative=true"]; }

              { keys = ["delete"]; commands = ["delete_files"]; }
              { keys = ["D"]; commands = ["delete_files"]; }

              { keys = ["p" "p"]; commands = ["paste_files"]; }
              { keys = ["p" "o"]; commands = ["paste_files --overwrite=true"]; }

              { keys = ["a"]; commands = ["rename_append"]; }
              { keys = ["A"]; commands = ["rename_prepend"]; }

              { keys = ["m" "f"]; commands = [":touch "]; }
              { keys = ["m" "k"]; commands = [":mkdir "]; }

              { keys = [" "]; commands = ["select --toggle=true"]; }
              { keys = ["v"]; commands = ["select --all=true --toggle=true"]; }
              { keys = ["V"]; commands = ["toggle_visual"]; }

              { keys = ["w"]; commands = ["show_tasks --exit-key=w"]; }
              { keys = ["b" "b"]; commands = ["bulk_rename"]; }
              { keys = ["="]; commands = ["set_mode"]; }

              # command prompt
              { keys = [":"]; commands = [":"]; }
              { keys = [";"]; commands = [":"]; }
              { keys = ["!"]; commands = [":shell "]; }

              { keys = ["/"]; commands = [":search "]; }
              { keys = ["|"]; commands = [":search_inc "]; }
              { keys = ["\\"]; commands = [":search_glob "]; }
              { keys = ["F"]; commands = ["search_fzf"]; }
              { keys = ["f"]; commands = ["custom_search rgfzf"]; }

              { keys = ["n"]; commands = ["search_next"]; }
              { keys = ["N"]; commands = ["search_prev"]; }

              { keys = ["s" "r"]; commands = ["sort reverse"]; }
              { keys = ["s" "l"]; commands = ["sort lexical"]; }
              { keys = ["s" "t"]; commands = ["sort mtime"]; }
              { keys = ["s" "n"]; commands = ["sort natural"]; }
              { keys = ["s" "s"]; commands = ["sort size"]; }
              { keys = ["s" "e"]; commands = ["sort ext"]; }

              { keys = ["z" "s"]; commands = ["linemode size"]; }
              { keys = ["z" "t"]; commands = ["linemode mtime"]; }
              { keys = ["z" "M"]; commands = ["linemode size | mtime"]; }
              { keys = ["z" "u"]; commands = ["linemode user"]; }
              { keys = ["z" "U"]; commands = ["linemode user | group"]; }
              { keys = ["z" "p"]; commands = ["linemode perm"]; }

              { keys = ["g" "r"]; commands = ["cd /"]; }
              { keys = ["g" "c"]; commands = ["cd ~/.config"]; }
              { keys = ["g" "s"]; commands = ["cd ~/.setup"]; }
              { keys = ["g" "d"]; commands = ["cd ~/Downloads"]; }
              { keys = ["g" "h"]; commands = ["cd ~/"]; }
              { keys = ["g" "n"]; commands = ["cd /nix/store"]; }
            ];
          };

          
          task_view = {
            keymap = [
              # arrow keys
              { keys = ["arrow_up"]; commands = ["cursor_move_up"]; }
              { keys = ["arrow_down"]; commands = ["cursor_move_down"]; }
              { keys = ["home"]; commands = ["cursor_move_home"]; }
              { keys = ["end"]; commands = ["cursor_move_end"]; }

              # vim-like keybindings
              { keys = ["j"]; commands = ["cursor_move_down"]; }
              { keys = ["k"]; commands = ["cursor_move_up"]; }
              { keys = ["g" "g"]; commands = ["cursor_move_home"]; }
              { keys = ["g" "e"]; commands = ["cursor_move_end"]; }
              { keys = ["G"]; commands = ["cursor_move_end"]; }

              { keys = ["w"]; commands = ["show_tasks"]; }
              { keys = ["escape"]; commands = ["show_tasks"]; }
            ];
          };

          help_view = {
            keymap = [
              # arrow keys
              { keys = ["arrow_up"]; commands = ["cursor_move_up"]; }
              { keys = ["arrow_down"]; commands = ["cursor_move_down"]; }
              { keys = ["home"]; commands = ["cursor_move_home"]; }
              { keys = ["end"]; commands = ["cursor_move_end"]; }

              # vim-like keybindings
              { keys = ["j"]; commands = ["cursor_move_down"]; }
              { keys = ["k"]; commands = ["cursor_move_up"]; }
              { keys = ["g" "g"]; commands = ["cursor_move_home"]; }
              { keys = ["g" "e"]; commands = ["cursor_move_end"]; }
              { keys = ["G"]; commands = ["cursor_move_end"]; }

              { keys = ["w"]; commands = ["show_tasks"]; }
              { keys = ["escape"]; commands = ["show_tasks"]; }
            ]; 
          };
        };
      };
    };
  };
}
