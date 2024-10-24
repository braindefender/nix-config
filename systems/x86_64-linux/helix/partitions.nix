{ config
, ...
}:

let
  username = config.plusultra.user.name;
in

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

    "/home/${username}/nexus" = {
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

  swapDevices = [
    { device = "/dev/disk/by-label/SWAP"; }
  ];

  # note: not working cause of snowfall lib not merging home-manager lib
  # use `ln -s ~/nexus/.trash ~/.local/share/Trash` to prevent cross-device link error

  # plusultra.system.home.file = {
  #   ".local/share/Trash".source = lib.hm.file.mkOutOfStoreSymlink "${username}/nexus/.trash";
  # };
}
