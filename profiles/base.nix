{ config, pkgs, ... }: {
  networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
  ];

  services.openssh.enable = true;

  users.users.root.initialPassword = "nixos";
}
