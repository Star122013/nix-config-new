{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-amd"
    "coretemp" # AMD CPU温度传感器
    "it87"
  ];
  boot.extraModprobeConfig = ''
    # 通用的参数：
    options it87 force_id=0x8622
  '';
  boot.kernelParams = [
    "acpi_enforce_resources=lax" # 允许驱动绕过ACPI资源冲突
  ];

  boot.extraModulePackages = [ ];
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_6_18.it87
    lm_sensors
  ];
  environment.etc."sysconfig/lm_sensors".text = ''
    HWMON_MODULES="it87 coretemp"
  '';

  hardware.fancontrol = {
    enable = false;

  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b9614265-3610-4c1b-af8a-cae69a6de4cc";
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/b9614265-3610-4c1b-af8a-cae69a6de4cc";
    fsType = "btrfs";
    options = [
      "subvol=home"
      "compress=zstd"
    ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/b9614265-3610-4c1b-af8a-cae69a6de4cc";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2D9E-0EA2";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.

  # networking.interfaces.enp10s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp16s0u1u1.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp9s0.useDHCP = lib.mkDefault true;

  services.openssh.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
