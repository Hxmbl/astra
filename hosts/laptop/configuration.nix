{ config, pkgs, ... }: {
  imports = [ ../../profiles/desktop.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "astra-laptop";

  # generated on install
  # imports = [ ./hardware-configuration.nix ];
  #
  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" ];
  };

  # battery
  powerManagement.enable = true;

  system.stateVersion = "24.11";
}
