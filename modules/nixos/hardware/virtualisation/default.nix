{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.hardware.virtualisation;
  gpuIds = [
    "10de:2216" # Video
    "10de:1aef" # Audio
  ];
  modules = [
    "vfio_virqfd"
    "vfio_pci"
    "vfio_iommu_type1"
    "vfio"
  ];
in
{
  options.plusultra.hardware.virtualisation = with types; {
    enable = mkBoolOpt false "Enable KVM GPU virtualisation?";
  };

  config = mkIf cfg.enable {
    boot = {
      zfs.enableUnstable = true;
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      kernelModules = modules;
      blacklistedKernelModules = [ "nvidia" "nouveau" "xpad" ];

      kernelParams = [ "intel_iommu=on" "preempt=voluntary" ];
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

    environment.systemPackages = with pkgs; [ virt-manager ];

    plusultra.user.extraGroups = [ "libvirtd" ];
  };
}
