{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.systemd.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  console.keyMap = "sv-latin1";

  users.users.user = {
    isNormalUser = true;
    hashedPassword = "$y$j9T$eUoA3MuwwWRr1JDKf5ob50$i9wgCmrTSVkT.HuOIVJg81mmmH1TOyQ0uR132Rm8ZE2";
    extraGroups = ["wheel" "input" "video" "fuse" "plugdev"];
    packages = with pkgs; [
      tree
    ];
  };


  # preservation handles machine-id persistence via bind mount; prevent
  # systemd from trying to commit it from tmpfs (which fails on btrfs-backed bind mount)
  systemd.services."systemd-machine-id-commit".enable = false;

  system.stateVersion = "26.05";
}
