{ channels, ... }:

final: prev: {
  inherit (channels.stable) vscode;
}
