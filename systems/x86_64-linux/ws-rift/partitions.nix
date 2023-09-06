{config, ...}:

let
  label = "NIX";
  btrfsOptions = [
    "space_cache=v2"
    "compress=zstd:2"
    "discard=async"
    "noatime"
    "ssd"
  ];
in {
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/${label}";
      fsType = "btrfs";
      options = btrfsOptions ++ ["subvol=root"];
    };

    "/home" = {
      device = "/dev/disk/by-label/${label}";
      fsType = "btrfs";
      options = btrfsOptions ++ ["subvol=home"];
    };

    "/nix" = {
      device = "/dev/disk/by-label/${label}";
      fsType = "btrfs";
      options = btrfsOptions ++ ["subvol=nix"];
    };

    "/log" = {
      device = "/dev/disk/by-label/${label}";
      fsType = "btrfs";
      options = btrfsOptions ++ ["subvol=log"];
      neededForBoot = true;
    };

    ${config.boot.loader.efi.efiSysMountPoint} = {
      device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-label/SWP"; }
  ];
}
