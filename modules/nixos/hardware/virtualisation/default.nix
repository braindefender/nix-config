{ options, config, pkgs, lib, ... }:

with lib;
with lib.plusultra;

let
  cfg = config.plusultra.hardware.virtualisation;
  gpuIds = [ "10de:2216" ];
in
{
  options.plusultra.hardware.virtualisation = with types; {
    enable = mkBoolOpt false "Enable virtualisation?";
  };

  config = mkIf cfg.enable {

    # Enable dcont to store VirtManager settings
    programs.dconf.enable = true;

    plusultra.user.extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      gnome.adwaita-icon-theme
    ];

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

    services.spice-vdagentd.enable = true;

    boot = {
      initrd.kernelModules = [
        "vfio"
        "vfio_pci"
        "vfio_virqfd"
        "vfio_iommu_type1"

        "nvidia"
        "nvidia_drm"
        "nvidia_uvm"
        "nvidia_modeset"
      ];

      kernelParams = [ "intel_iommu=on" "iommu=pt" "vfio-pci.ids=10de:2216" ];

      # # Turn off NVidia Drivers
      # blacklistedKernelModules = [ "nvidia" "nouveau" ];
    };

    services.udev.extraRules = ''
      SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
    '';

    hardware.opengl.enable = true;
  };
}
