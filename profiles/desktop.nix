{ config, pkgs, zen-browser, ... }: {
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
    ghostty
    jetbrains-toolbox
    localsend
    obsidian
    rustdesk
    visual-studio-code
    wireshark
    zed-editor
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
