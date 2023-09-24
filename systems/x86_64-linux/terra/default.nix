# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

with lib;
with lib.plusultra;

{
  imports = [
    ./hardware.nix
    ./partitions.nix
  ];

  plusultra = {
    suites = {
      common = enabled;
      development = enabled;
    };
    system = {
      boot.grub = enabled;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "23.05";

}
