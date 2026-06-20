# astra
The abstract "Operating System." Everything. One "insecure" place.
<sub>(Yes its just NixOS with stuff)</sub>

## what
A NixOS flake that describes every machine I own. One repo, one source of truth, zero excuses.

## Why
Because reinstalling is a skill issue.

## quick start
```bash
# from any NixOS live env or existing NixOS install
bash <(curl -s https://raw.githubusercontent.com/Hxmbl/astra/main/install.sh) vm-nano
```

or clone and run manually:
```bash
git clone https://github.com/Hxmbl/astra.git && cd astra
sudo nixos-rebuild switch --flake .#vm-nano
```

for laptop (generates hardware config automatically):
```bash
bash <(curl -s https://raw.githubusercontent.com/Hxmbl/astra/main/install.sh) laptop
```

## login
default user: `user`
default password: `nixos`

run `passwd` after first login to set your real password.

## customization
everything lives in `~/astra/`. here's what you'd edit:

| want to change | edit this |
|---|---|
| username | `hosts/<host>/configuration.nix` — `users.users.user` (rename `user` to your name) |
| password | same file — `initialPassword` |
| hostname | same file — `networking.hostName` |
| desktop packages | `profiles/desktop.nix` — `environment.systemPackages` |
| dev tools | `profiles/core.nix` — `environment.systemPackages` |
| hyprland binds | `home/default.nix` — `xdg.configFile."hypr/hyprland.conf"` |
| starship prompt | `home/default.nix` — `programs.starship.settings` |
| git config | `home/default.nix` — `programs.git` (set `userName` and `userEmail`) |
| ghostty terminal | `home/default.nix` — `xdg.configFile."ghostty/config"` |
| hyprlock screen | `home/default.nix` — `xdg.configFile."hypr/hyprlock.conf"` |
| server services | `hosts/server/configuration.nix` — `virtualisation.oci-containers` |
| server firewall | same file — `networking.firewall` |

after editing, rebuild:
```bash
sudo nixos-rebuild switch --flake ~/astra#<host>
```

## machines
| host | profile | status |
|------|---------|--------|
| vm-nano | base | working |
| vm-mini | core | working |
| vm-full | desktop | working |
| laptop | desktop | wip |
| server | base | working |
| server-core | base | working |

## structure
```
astra/
├── flake.nix
├── install.sh        # one-liner setup
├── flakes/           # isolated third-party flakes (cursor, zen-browser)
├── hosts/            # per-machine configs
├── home/             # home-manager config
└── profiles/         # base → core → desktop
```

## secrets
yes please

## status
Works on my machine. Fix it if it doesn't work for you.
