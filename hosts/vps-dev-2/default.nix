{
  boot.isContainer = true;

  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";

  services.fail2ban.enable = false;

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "sv-latin1";

  systemd.suppressedSystemUnits = [
    "dev-mqueue.mount"
    "sys-kernel-debug.mount"
    "sys-fs-fuse-connections.mount"
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "vps-dev-2";
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  system.stateVersion = "24.11";
}