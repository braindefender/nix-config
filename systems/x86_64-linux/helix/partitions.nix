{ ... }:

{
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
    };

    "/" = {
      device = "vpool/root";
      fsType = "zfs";
    };

    "/nix" = {
      device = "vpool/nix";
      fsType = "zfs";
    };

    "/home" = {
      device = "vpool/home";
      fsType = "zfs";
    };

    "/data" = {
      device = "vpool/data";
      fsType = "zfs";
    };

    "/virt" = {
      device = "vpool/virt";
      fsType = "zfs";
    };

    "/virt/ubuntu" = {
      device = "vpool/virt/ubuntu";
      fsType = "zfs";
    };

    "/virt/windows" = {
      device = "vpool/virt/windows";
      fsType = "zfs";
    };
  };

  swapDevices = [{ device = "/dev/disk/by-label/SWAP"; }];
}
