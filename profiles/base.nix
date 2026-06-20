{ config, pkgs, ... }: {
  networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    helix
    htop
    tty-clock
    ripgrep
  ];

  environment.variables = {
    EDITOR = "hx";
    PAGER = "less";
  };

  services.openssh.enable = true;
}
