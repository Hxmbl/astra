{ config, pkgs, ... }: {
  imports = [ ./base.nix ];

  environment.systemPackages = with pkgs; [
    adb
    btop
    fd
    fastfetch
    gh
    go
    jq
    neovim
    python3
    rustup
    speedtest-cli
    tailscale
    tmux
    zoxide
  ];

  virtualisation.docker.enable = true;
  services.tailscale.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.user = import ../home/default.nix;

}
