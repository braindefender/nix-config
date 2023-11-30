{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.apps.vscode;
  font = "CaskaydiaCove Nerd Font Mono";
  prettier = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  wayland-fix = { NIXOS_OZONE_WL = "1"; };
in
{
  options.plusultra.apps.vscode = with types; {
    enable = mkBoolOpt false "Enable Visual Studio Code?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vscode nixpkgs-fmt ];
    environment.sessionVariables = wayland-fix;

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

    plusultra.system.home.extraOptions = {
      home.sessionVariables = wayland-fix;

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
            key = "ctrl+shift+[Semicolon]";
            command = "workbench.action.terminal.new";
          }
          {
            key = "ctrl+[Semicolon]";
            command = "workbench.action.terminal.toggleTerminal";
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
          "workbench.settings.useSplitJSON" = true;
          "workbench.layoutControl.type" = "toggles";
          "workbench.sideBar.location" = "right";
          "workbench.list.smoothScrolling" = true;
          "workbench.tree.renderIndentGuides" = "always";
          "workbench.tree.indent" = 12;

          "explorer.confirmDelete" = false;
          "explorer.fileNesting.expand" = false;

          "files.autoSave" = "onFocusChange";
          "files.insertFinalNewline" = true;
          "files.trimFinalNewlines" = true;
          "files.trimTrailingWhitespace" = true;

          # Cursor
          "editor.cursorWidth" = 2;
          "editor.cursorBlinking" = "solid";
          "editor.cursorSurroundingLines" = 4;

          # Font
          "editor.fontSize" = 13;
          "editor.lineHeight" = 1.45;
          "editor.fontLigatures" = true;
          "editor.fontWeight" = "400";
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
          "editor.minimap.showSlider" = "always";
          "editor.minimap.renderCharacters" = false;
          "editor.accessibilitySupport" = "off";
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

          # Nushell Integration
          "terminal.integrated.defaultProfile.linux" = "nushell";
          "terminal.integrated.profiles.linux" = {
            "nushell" = {
              path = "${pkgs.nushell}/bin/nu";
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

          "typescript.updateImportsOnFileMove.enabled" = "always";

          # Turn off stupid auto-formatter that breaks files
          "[less]" = {
            "editor.formatOnSave" = false;
          };

          # Prettier Everything
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

          # Files Associations
          "files.associations" = {
            "*.ron" = "rust";
          };
        };
      };
    };
  };
}
