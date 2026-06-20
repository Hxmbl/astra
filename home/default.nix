{ config, pkgs, ... }: {
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.11";

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh.shellAliases = {
    la = "ls -a";
    p1 = "ping 1.1.1.1";
    speed = "speedtest";
    speed-bytes = "speedtest -u auto-binary-bytes";
    clock = "tty-clock -csbt";
    tty-clock = "tty-clock -csbt";
    where = "which";
    py = "python";
    py3 = "python3";
  };

}
