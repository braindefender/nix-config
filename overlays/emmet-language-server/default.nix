{ channels, ... }:

final: prev: {
  inherit (channels.unstable) emmet-language-server;
}
