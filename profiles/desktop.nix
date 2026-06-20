{ config, pkgs, zen-browser, cursor, ... }: {
  imports = [ ./core.nix ];

  programs.hyprland.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    android-studio
    cursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    ghostty
    hyprlock
    jetbrains-toolbox
    localsend
    obsidian
    rustdesk
    visual-studio-code
    wireshark
    rofi-wayland
    zed-editor
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
