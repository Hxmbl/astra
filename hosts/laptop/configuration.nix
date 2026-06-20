{ config, pkgs, ... }: {
  imports = [
    ../../profiles/desktop.nix
    # ./hardware-configuration.nix  # generated on install
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "astra-laptop";

  # PLACEHOLDER — replaced by hardware-configuration.nix on real install
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    initialPassword = "nixos";
  };

  # --- swap ---
  # zram for compressed memory swap (scales with RAM)
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  # static swap file (8GB floor, increase if you have the storage)
  swapDevices = [{
    device = "/swapfile";
    size = 8192;
  }];

  # --- audio ---
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;

  # --- bluetooth ---
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # --- printer/scanner ---
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  hardware.sane.enable = true;

  # battery
  powerManagement.enable = true;

  system.stateVersion = "24.11";
}
