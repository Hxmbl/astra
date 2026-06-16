{ config, pkgs, ... }: {
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.11";

  programs.git.enable = true;
  programs.helix.enable = true;
  programs.zsh.enable = true;
}
