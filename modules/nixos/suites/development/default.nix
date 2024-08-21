{ options, config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

let cfg = config.plusultra.suites.development;

in {
  options.plusultra.suites.development = with types; {
    enable = mkBoolOpt false "Enable development configuration?";
  };

  config = mkIf cfg.enable {

    # Docker
    virtualisation.docker = {
      # enable = true;
      storageDriver = "zfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    plusultra.user.extraGroups = [ "docker" ];
    # plusultra.hardware.networking.hosts = { };

    # Packages
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
      docker-compose
      # Web
      nodejs
      bun
      emmet-language-server
      turso-cli
      tokei
    ] ++ (with pkgs.nodePackages_latest; [
      prettier
      typescript-language-server
      yarn
      pnpm
    ]);
  };
}
