# astra
The abstract "Operating System." Everything. One "insecure" place.
<sub>(Yes its just NixOS with stuff)</sub>

## what
A NixOS flake that describes every machine I own. One repo, one source of truth, zero excuses.

## Why
Because reinstalling is a skill issue.

## machines
pray

## structure
```
astra/
├── flake.nix
├── hosts/          # per-machine configs
├── modules/        # reusable bits
└── profiles/       # workstation, server, minimal
```

## secrets
yes please

## usage
```bash
nixos-rebuild switch --flake .#hostname
```

## status
Works on my machine. Fix it if it doesn't work for you.
