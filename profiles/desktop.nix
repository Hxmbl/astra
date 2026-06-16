{ config, pkgs, ... }: {
  imports = [ ./core.nix ];

  services.displayManager.gdm.enable = true;

  programs.hyprland.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    android-studio
    ghostty
    rustdesk
    visual-studio-code
    zed-editor
    zen-browser
  ];
}
