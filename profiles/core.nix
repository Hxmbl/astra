{ config, pkgs, ... }: {
  imports = [ ./base.nix ];

  environment.systemPackages = with pkgs; [
    adb
    btop
    fd
    gh
    go
    jq
    neovim
    python3
    rustup
    speedtest-cli
    tailscale
  ];

  virtualisation.docker.enable = true;
  services.tailscale.enable = true;
}
