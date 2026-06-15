{ config, pkgs, ... }: {
  imports = [ ../../../profiles/desktop.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "astra-vm-full";

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
  };

  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "24.11";
}
