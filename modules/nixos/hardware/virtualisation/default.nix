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
      kernelModules = modules;
      blacklistedKernelModules = [ "nvidia" "nouveau" ];

      kernelParams = [ "intel_iommu=on" "pcie_acs_override=downstream,multifunction" ];
      extraModprobeConfig = "options vfio-pci ids=" + lib.concatStringsSep "," gpuIds;

      # kernelPatches = [
      #   {
      #     name = "add-acs-overrides";
      #     patch = pkgs.fetchurl {
      #       name = "add-acs-overrides.patch";
      #       url =
      #         "https://aur.archlinux.org/cgit/aur.git/plain/add-acs-overrides.patch?h=linux-vfio&id=6f5c5ff2e42abf6606564383d5cb3c56b13d895e";
      #       sha256 = "1qd68s9r0ppynksbffqn2qbp1whqpbfp93dpccp9griwhx5srx6v";
      #     };
      #   }
      # ];
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
    };

    environment.systemPackages = with pkgs; [ virt-manager ];

    plusultra.user.extraGroups = [ "libvirtd" ];
    programs.hyprland.enableNvidiaPatches = false;
  };
}
