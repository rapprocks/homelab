{ config, pkgs, inputs, ... }:

{
  # Common configuration for all servers
  
  # Enable SSH
  services.openssh = {
    enable = true;
    ports = [ 33001 ];
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      KbdInteractiveAuthentication = false;
    };
  };

  # Enables vscode server to be installed.
  programs.nix-ld.enable = true;

  users.users.root.hashedPassword = "!"; # Disables root login
  users.users.admin = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    password = "admin";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIECuco63b+c3huIxsB9UoFChCQBFkjpThaOnFzu139IF philip@nixwrk"
    ];
  };

  # Enable sudo without password for wheel group (for ansible)
  security.sudo.wheelNeedsPassword = false;

  # Basic packages
  environment.systemPackages = with pkgs; [
    neovim
    evil-helix
    fzf
    git
    curl
    wget
    htop
  ];

 # system.autoUpgrade = {
 #   enable = true;
 #   flake = inputs.self.outPath;
 #   flags = [
 #     "--update-input"
  #    "nixpkgs"
  #    "--no-write-lock-file"
  #    "-L" # print build logs
  #  ];
  #  dates = "02:00";
  #  randomizedDelaySec = "45min";
  #};

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
