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
      ];

      kernelParams = [
        "iommu=pt"
        "intel_iommu=on"
      ] ++ lib.optional
        cfg.enable
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIds);

      # # Turn off NVidia Drivers
      # blacklistedKernelModules = [ "nvidia" "nouveau" ];
    };

    services.udev.extraRules = ''
      SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
    '';

    hardware.opengl.enable = true;
  };
}
