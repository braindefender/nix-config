{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.suites.development;

in {
  options.plusultra.suites.development = with types; {
    enable = mkBoolOpt false "Enable development configuration?";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # C/C++
      clang
      clang-tools
      cmake
      # Rust
      rust-analyzer
      rustfmt
      cargo
      # Others
      go
      lldb
      sapling
      # Web
      nodejs
      bun
    ] ++ (with pkgs.nodePackages_latest; [
      prettier
      typescript-language-server
      vscode-langservers-extracted
      yarn
      pnpm
    ]);
  };
}
