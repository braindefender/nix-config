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

    "/virt" = {
      device = "rpool/virt";
      fsType = "zfs";
    };

    "/virt/ubuntu" = {
      device = "rpool/virt/ubuntu";
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
  };

  swapDevices = [ ];

  # needed for ZFS configuration
  networking.hostId = "b27a47ea";
}
