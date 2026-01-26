{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.kernelParams = [ 
	"udev.log_level=3" 
	"acpi_backlight=video" 
	"fbcon=nodefer" 
	"enable_dc=2" 
	"enable_fbc=1" 
	"fastboot=1" 
	"i915.enable_guc=2" 
	"slab_nomerge"
	"init_on_alloc=1"
	"init_on_free=1"
	"page_alloc.shuffle=1"
	"pti=on"
	"nowatchdog" 
	"quiet" 
	"splash" 
	"systemd.show_status=false" 
	"rd.systemd.show_status=false" 
	"loglevel=3"
    ];
  
 fileSystems."/" =
    { device = "/dev/disk/by-uuid/300c6b4c-e7ac-44fc-b3f3-41522ac52904";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/86f821a6-5d7d-4d5b-91e8-335580e3b60d";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6F88-6107";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  # Hardening feature /ram  
  # The actual /tmp is mounted automatically by the system and /tmpfs is another path

  fileSystems."/ram" = 
  { fsType = "tmpfs";
    device = "tmpfs";
    options = [ "noexec" "nosuid" "nodev" "relatime" "size=6G" ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
hardware.enableAllFirmware = true;
}
