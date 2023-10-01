# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

{
  boot = {
    # Before boot
    initrd = {
      # Turned off cause VFIO Passthrough
      # kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod" ];
    };

    # After boot
    kernelModules = [ "kvm-intel" ];
  };

  hardware = {
    # Intel microcode
    cpu.intel.updateMicrocode =
      mkDefault config.hardware.enableRedistributableFirmware;

    # Turned off cause VFIO Passthrough
    # nvidia = {
    #   modesetting.enable = true;
    #   powerManagement.enable = true;
    # };
  };

  # Bluetooth service
  services.blueman.enable = true;

  # Nvidia drivers for X and Wayland
  # Turned off cause VFIO Passthrough
  # services.xserver.videoDrivers = [ "nvidia" ];

  # 64-Bit system target
  nixpkgs.hostPlatform = mkDefault "x86_64-linux";
}
