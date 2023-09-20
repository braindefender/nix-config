{ config, ... }:

{
  fileSystems = {
    "/" = {
      device = "rpool/root";
      fsType = "zfs";
    };

    "/home" = {
      device = "rpool/home";
      fsType = "zfs";
    };

    "/data" = {
      device = "rpool/data";
      fsType = "zfs";
    };

    "/nix" = {
      device = "rpool/nix";
      fsType = "zfs";
    };

    "/boot" = {
      device = "/dev/disk/by-label/NIXBOOT";
      fsType = "vfat";
    };

    "/boot/EFI" = {
      device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  # needed for ZFS configuration
  networking.hostId = "b27a47ea";
}
