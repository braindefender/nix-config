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
      modeling = enabled;
      work = enabled;
    };
    hardware = {
      video = enabled;
      domains = enabled;
    };
    system = {
      boot.grub = enabled;
    };
  };
}
