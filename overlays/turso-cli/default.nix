{ channels, ... }:

final: prev: {
  inherit (channels.unstable) turso-cli;
}
