{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.hardware.virtualisation;
  gpuIds = [
    "10de:2216" # Video
    "10de:1aef" # Audio
  ];
in
{
  options.plusultra.hardware.virtualisation = with types; {
    enable = mkBoolOpt false "Enable KVM GPU virtualisation?";
  };

  config = mkIf cfg.enable {
    boot = {
      zfs.package = pkgs.zfs_unstable;
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      kernelModules = [
        "kvm-intel"
        "vfio_virqfd"
        "vfio_pci"
        "vfio_iommu_type1"
        "vfio"
      ];
      blacklistedKernelModules = [ "nvidia" "nouveau" "xpad" ];

      kernel.sysctl = {
        "vm.nr_hugepages" = 16;
        "kernel.shmmax" = 17179869184;
        "vm.hugetlb_shm_group" = 302;
      };

      kernelParams = [
        "intel_iommu=on"
        "preempt=voluntary"
        "default_hugepages_size=1G"
        "hugepages=16"
        "hugepages_size=1G"
      ];
      extraModprobeConfig = "options vfio-pci ids=" + lib.concatStringsSep "," gpuIds;
    };

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };

    environment.systemPackages = with pkgs; [
      virt-manager
      lm_sensors
      libhugetlbfs
    ];

    plusultra.user.extraGroups = [ "libvirtd" "kvm" ];
  };
}
