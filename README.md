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

## machines
| host | profile | status |
|------|---------|--------|
| vm-nano | base | working |
| vm-mini | core | working |
| vm-full | desktop | working |
| laptop | desktop | wip |
| desktop | — | planned |
| server | — | planned |

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
