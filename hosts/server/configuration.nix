{ config, pkgs, ... }: {
  imports = [ ../../profiles/base.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "astra-server";

  # PLACEHOLDER — replace with real mounts on install
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    initialPassword = "nixos";
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22     # ssh
      80     # http (caddy)
      443    # https (caddy)
      3001   # dashdot
      6379   # valkey
      8080   # searxng
      21115  # rustdesk hbbs
      21116  # rustdesk hbbs
      21117  # rustdesk hbbr
      21118  # rustdesk webclient
    ];
    allowedUDPPorts = [
      21116  # rustdesk hbbs
    ];
  };

  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
  };

  services.caddy = {
    enable = true;
    email = "admin@astra";
  };

  # --- services ---

  # dashdot — server dashboard
  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      dashdot = {
        image = "mauricenino/dashdot:latest";
        ports = [ "3001:3001" ];
        volumes = [ "/:/mnt/host:ro" ];
        autoStart = true;
      };

      searxng-valkey = {
        image = "valkey/valkey:9-alpine";
        volumes = [ "searxng-valkey-data:/data" ];
        autoStart = true;
      };

      searxng-core = {
        image = "searxng/searxng:latest";
        ports = [ "8080:8080" ];
        dependsOn = [ "searxng-valkey" ];
        volumes = [
          "./searxng:/etc/searxng:rw"
        ];
        environment = {
          SEARXNG_VALKEY_URL = "redis://searxng-valkey:6379";
        };
        autoStart = true;
      };

      rustdesk-hbbs = {
        image = "rustdesk/rustdesk-server:latest";
        cmd = [ "hbbs" "-r" "astra-server:21115" ];
        ports = [
          "21115:21115"
          "21116:21116"
          "21116:21116/udp"
          "21118:21118"
        ];
        volumes = [ "rustdesk-data:/root" ];
        autoStart = true;
      };

      rustdesk-hbbr = {
        image = "rustdesk/rustdesk-server:latest";
        cmd = [ "hbbr" ];
        ports = [ "21117:21117" ];
        volumes = [ "rustdesk-data:/root" ];
        autoStart = true;
      };
    };
  };

  system.stateVersion = "24.11";
}
