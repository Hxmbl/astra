{ config, pkgs, ... }: {
  imports = [ ../../profiles/desktop.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "astra-laptop";

  # generated on install
  # imports = [ ./hardware-configuration.nix ];

  # PLACEHOLDER — replace with UUID mounts from nixos-generate-config on real install
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
    initialPassword = "nixos";
  };

  # battery
  powerManagement.enable = true;

  system.stateVersion = "24.11";
}
