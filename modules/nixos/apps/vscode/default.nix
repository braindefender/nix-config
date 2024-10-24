{ config
, lib
, pkgs
, ...
}:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.vscode;
  font = "CaskaydiaCove Nerd Font Mono";
  prettier = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
in

{
  options.plusultra.apps.vscode = with types; {
    enable = mkBoolOpt false "Enable Visual Studio Code?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vscode-with-extensions ];

    plusultra.system.home.file = {
      ".vimrc".text = ''
        " use jkl~ instead of hjkl as ergonomic alternative over historic
        " note: there is a `~` symbol instead of `;` because of Wellum keyboard layout
        noremap ~ l
        noremap l k
        noremap k j
        noremap j h
        noremap h ~
      '';
    };

    services.vscode-server.enable = true;
    # Needed for VSCode Server to work properly
    programs.nix-ld.enable = true;

    plusultra.system.home.extraOptions = {
      programs.vscode = {
        enable = true;
        mutableExtensionsDir = true;

        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim # Vim Mode
          jnoortheen.nix-ide # Nix IDE
          eamodio.gitlens # GitLens
          dbaeumer.vscode-eslint # ESLint
          esbenp.prettier-vscode # Prettier
          yzhang.markdown-all-in-one # Markdown AIO
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # Ayu colorscheme is not in vscode-extensions, so we use marketplace
          {
            name = "ayu";
            publisher = "teabyii";
            version = "1.0.5";
            sha256 = "+IFqgWliKr+qjBLmQlzF44XNbN7Br5a119v9WAnZOu4=";
          }
        ];

        keybindings = [
          {
            key = "ctrl+p";
            command = "-extension.vim_ctrl+p";
          }
          {
            key = "ctrl+shift+'";
            command = "workbench.action.terminal.new";
          }
          {
            key = "ctrl+'";
            command = "workbench.action.terminal.toggleTerminal";
          }
          {
            key = "alt+left";
            command = "workbench.action.focusPreviousGroup";
          }
          {
            key = "alt+right";
            command = "workbench.action.focusNextGroup";
          }
        ];

        userSettings = {
          # Turn off fucking prompts
          "update.mode" = "none";
          "telemetry.telemetryLevel" = "off";
          "git.openRepositoryInParentFolders" = "always";
          "security.workspace.trust.enabled" = false;
          "extensions.autoCheckUpdates" = false;
          "extensions.ignoreRecommendations" = true;
          "gitlens.plusFeatures.enabled" = false;

          # Window
          "window.titleBarStyle" = "custom";
          "window.zoomLevel" = 1;

          # Workbench
          "workbench.settings.useSplitJSON" = false;
          "workbench.layoutControl.type" = "toggles";
          "workbench.activityBar.location" = "top";
          "workbench.sideBar.location" = "right";
          "workbench.list.smoothScrolling" = true;
          "workbench.tree.renderIndentGuides" = "always";
          "workbench.tree.indent" = 12;

          "explorer.confirmDelete" = false;
          "explorer.fileNesting.expand" = false;
          "explorer.autoRevealExclude" = {
            "**/node_modules" = false;
          };

          "files.autoSave" = "onFocusChange";
          "files.insertFinalNewline" = true;
          "files.trimFinalNewlines" = true;
          "files.trimTrailingWhitespace" = true;

          # Cursor
          "editor.cursorWidth" = 2;
          "editor.cursorBlinking" = "solid";
          "editor.cursorSurroundingLines" = 10;

          # Font
          "editor.fontSize" = 13;
          "editor.lineHeight" = 1.45;
          "editor.fontLigatures" = true;
          "editor.fontWeight" = "normal";
          "editor.fontFamily" = font;

          # Colorscheme
          "workbench.colorTheme" = "Ayu Mirage";

          # Behaviour
          "editor.suggest.preview" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnPaste" = true;
          "editor.linkedEditing" = true;
          "editor.lineNumbers" = "relative";
          "editor.renderLineHighlight" = "all";
          "editor.gotoLocation.multipleDefinitions" = "goto";
          "emmet.useInlineCompletions" = true;

          # Scroll
          "editor.smoothScrolling" = true;
          "editor.stickyScroll.enabled" = true;
          "editor.scrollBeyondLastLine" = false;
          "editor.scrollbar.verticalScrollbarSize" = 8;
          "editor.scrollbar.horizontalScrollbarSize" = 8;

          # Others
          "editor.minimap.autohide" = true;
          "editor.minimap.showSlider" = "always";
          "editor.minimap.renderCharacters" = false;
          "editor.accessibilitySupport" = "off";
          "editor.unicodeHighlight.includeComments" = false;
          "editor.unicodeHighlight.allowedLocales" = {
            ru = true;
          };

          # Terminal
          "terminal.integrated.cursorStyle" = "underline";
          "terminal.integrated.fontSize" = 13;
          "terminal.integrated.fontWeight" = "400";
          "terminal.integrated.fontFamily" = font;
          "terminal.integrated.scrollback" = 10000;
          "terminal.integrated.smoothScrolling" = true;

          # ZSH Integration
          "terminal.integrated.defaultProfile.linux" = "zsh";
          "terminal.integrated.profiles.linux" = {
            "zsh" = {
              path = "${pkgs.zsh}/bin/zsh";
            };
          };

          # VIM

          ## VIM Settings
          "vim.leader" = " ";
          "vim.history" = 1000;
          "vim.inccommand" = "append"; # show inline substitutions
          "vim.useSystemClipboard" = true;
          "vim.vimrc.enable" = true;

          ## VIM Keybindings
          "vim.handleKeys" = {
            "<C-d>" = true;
            "<C-f>" = false;
            "<C-s>" = false;
            "<C-z>" = false;
          };

          "vim.insertModeKeyBindingsNonRecursive" = [
            {
              before = [ "j" "k" ];
              after = [ "<Esc>" "l" ];
            }
          ];

          ## VIM Plugins
          "vim.camelCaseMotion.enable" = true;
          "vim.highlightedyank.enable" = true;

          # Language-specific settings

          ## Nix
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.serverSettings" = {
            "nixd" = {
              "nixpkgs" = {
                "expr" = "import <nixpkgs> { }";
              };
              "formatting" = {
                "command" = [ "nixpkgs-fmt" ];
              };
            };
          };

          ## Others
          "javascript.updateImportsOnFileMove.enabled" = "always";
          "typescript.updateImportsOnFileMove.enabled" = "always";
          "markdown.extension.toc.updateOnSave" = false;

          ## Turn off stupid auto-formatter that breaks files
          "[less]" = {
            "editor.formatOnSave" = false;
          };

          ## Prettier Everything
          "[html]" = prettier;
          "[css]" = prettier;
          "[json]" = prettier;
          "[jsonc]" = prettier;
          "[astro]" = prettier;
          "[markdown]" = prettier;
          "[javascript]" = prettier;
          "[javascriptreact]" = prettier;
          "[typescript]" = prettier;
          "[typescriptreact]" = prettier;

          ## Files Associations
          "files.associations" = {
            "*.ron" = "rust";
          };
        };
      };
    };
  };
}
