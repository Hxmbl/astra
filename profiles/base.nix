{ config, pkgs, ... }: {
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];
  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    curl
    git
    helix
    htop
    ripgrep
    tty-clock
    wget
  ];

  environment.variables = {
    EDITOR = "hx";
    PAGER = "less";
  };

  services.openssh.enable = true;
}
