{ config, lib, pkgs, ... }:

with lib;
with lib.plusultra;

{
  boot = {
    # Before boot
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
    };

    # After boot
    kernelModules = [ "kvm-intel" ];
  };

  powerManagement.cpuFreqGovernor = "performance";

  hardware = {
    # Intel microcode
    cpu.intel.updateMicrocode =
      mkDefault config.hardware.enableRedistributableFirmware;
  };

  # Bluetooth service
  services.blueman.enable = true;

  # Needed for ZFS configuration // https://search.nixos.org/options?channel=unstable&show=networking.hostId
  networking.hostId = "b27a47ea";

  # 64-Bit system target
  nixpkgs.hostPlatform = mkDefault "x86_64-linux";
}
