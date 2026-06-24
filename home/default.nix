{ config, pkgs, ... }: {
  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "24.11";

  xdg.enable = true;

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      character.success_symbol = "[❯](bold green)";
      character.error_symbol = "[❯](bold red)";
      directory.truncation_length = 3;
      git_branch.symbol = " ";
      git_status = {
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        modified = "!";
        staged = "+";
        untracked = "?";
      };
      cmd_duration = {
        min_time = 2000;
        format = "took [\${duration}](bold yellow) ";
      };
      nodejs.symbol = " ";
      python.symbol = " ";
      rust.symbol = " ";
      docker_context.symbol = " ";
      golang.symbol = " ";
    };
  };

  programs.git = {
    enable = true;
    # TODO: set your name and email
    # userName = "you";
    # userEmail = "you@example.com";
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      diff.algorithm = "histogram";
      merge.conflictstyle = "zdiff3";
      rerere.enabled = true;
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "-version:refname";
    };
  };

  programs.tmux.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."ghostty/config".text = ''
    window-padding-x = 4
    window-padding-y = 4
    scrollback-limit = 10000
    clipboard-paste-protection = false
    window-decoration = false
    font-family = JetBrainsMono Nerd Font
    confirm-close-surface = false
  '';

  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = screenshot
      blur_passes = 4
      blur_size = 8
      noise = 0.0117
      contrast = 0.8916
      brightness = 0.8172
      vibrancy = 0.1686
      vibrancy_darkness = 0.5810
    }

    clock {
      monitor =
      size = 200, 100
      position = 0, 80
      halign = center
      valign = center
      font_size = 64
      font_family = JetBrains Mono
      color = rgba(33ccffee)
      format = {:%H:%M}
    }

    date {
      monitor =
      size = 200, 50
      position = 0, 10
      halign = center
      valign = center
      font_size = 20
      font_family = JetBrains Mono
      color = rgba(33ccffaa)
      format = {:%A, %B %d}
    }

    input-field {
      monitor =
      size = 300, 40
      outline_thickness = 2
      dots_size = 0.25
      dots_spacing = 0.2
      dots_center = true
      outer_color = rgba(33ccffee)
      inner_color = rgba(202020aa)
      font_color = rgba(33ccffee)
      fade_on_empty = false
      placeholder_text =
      hide_input = true
      position = 0, 60
      halign = center
      valign = bottom
    }
  '';

  xdg.configFile."hypr/hyprland.conf".text = ''
    monitor = ,preferred,auto,1

    general {
      gaps_in = 5
      gaps_out = 10
      border_size = 2
      col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
      col.inactive_border = rgba(595959aa)
      layout = dwindle
      allow_tearing = false
    }

    decoration {
      rounding = 10
      blur {
        enabled = true
        size = 3
        passes = 1
        vibrancy = 0.1696
      }
      shadow {
        enabled = true
        range = 4
        render_power = 3
        color = rgba(1a1a1aee)
      }
    }

    animations {
      enabled = true
      bezier = ease, 0.25, 0.1, 0.25, 1
      animation = windows, 1, 7, ease
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 8, default
      animation = fade, 1, 7, ease
      animation = workspaces, 1, 6, default
    }

    dwindle {
      pseudotile = true
      preserve_split = true
    }

    input {
      kb_layout = us
      follow_mouse = 1
      touchpad {
        natural_scroll = true
      }
    }

    gestures {
      workspace_swipe = true
      workspace_swipe_fingers = 3
    }

    $mod = SUPER

    bind = $mod, Return, exec, ghostty
    bind = $mod, Q, killactive,
    bind = $mod, L, exec, hyprlock
    bind = $mod, V, togglefloating,
    bind = $mod, F, fullscreen,
    bind = $mod, Space, exec, rofi -show drun
    bind = $mod, P, pseudo,
    bind = $mod, J, togglesplit,
    bind = $mod, left, movefocus, l
    bind = $mod, right, movefocus, r
    bind = $mod, up, movefocus, u
    bind = $mod, down, movefocus, d
    bind = $mod, 1, workspace, 1
    bind = $mod, 2, workspace, 2
    bind = $mod, 3, workspace, 3
    bind = $mod, 4, workspace, 4
    bind = $mod, 5, workspace, 5
    bind = $mod, 6, workspace, 6
    bind = $mod, 7, workspace, 7
    bind = $mod, 8, workspace, 8
    bind = $mod, 9, workspace, 9
    bind = $mod, 0, workspace, 10
    bind = $mod SHIFT, 1, movetoworkspace, 1
    bind = $mod SHIFT, 2, movetoworkspace, 2
    bind = $mod SHIFT, 3, movetoworkspace, 3
    bind = $mod SHIFT, 4, movetoworkspace, 4
    bind = $mod SHIFT, 5, movetoworkspace, 5
    bind = $mod SHIFT, 6, movetoworkspace, 6
    bind = $mod SHIFT, 7, movetoworkspace, 7
    bind = $mod SHIFT, 8, movetoworkspace, 8
    bind = $mod SHIFT, 9, movetoworkspace, 9
    bind = $mod SHIFT, 0, movetoworkspace, 10
    bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bind = , XF86MonBrightnessUp, exec, brightnessctl set 5%+
    bind = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
    bindm = $mod, mouse:272, movewindow
    bindm = $mod, mouse:273, resizewindow
  '';

  programs.zsh.shellAliases = {
    ls = "eza --long";
    la = "eza --long --all";
    p1 = "ping 1.1.1.1";
    speed = "speedtest";
    speed-bytes = "speedtest -u auto-binary-bytes";
    clock = "tty-clock -csbt";
    tty-clock = "tty-clock -csbt";
    where = "which";
    py = "python3";
    ff = "fastfetch";
    source-pyvenv = "source .venv/bin/activate";
    where = "which"
  };
}
