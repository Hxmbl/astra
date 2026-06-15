{ config, pkgs, ... }: {
  imports = [ ./core.nix ];

  environment.systemPackages = with pkgs; [
    android-studio
    ghostty
    rustdesk
    visual-studio-code
    zed-editor
    zen-browser
  ];
}
