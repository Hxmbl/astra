{ config, pkgs, ... }: {
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
    rustdesk
    visual-studio-code
    zed-editor
    zen-browser
  ];
}
