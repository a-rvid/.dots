{ pkgs, ... }:

{
  imports = [
    ../../modules/bundle.nix
  ];

  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-partlabel/disk-main-root";
    allowDiscards = true;
  };

  messaging.enable = true;
  gaming = {
    enable = true;
    steam.enable = true;
    amd.enable = true;
  };
  dev.enable = true;
  services = {
    hardware.deepcool-digital-linux.enable = true;
    flatpak.enable = true;
  };

  networking.hostName = "legolas";

  desktop.enable = true;
}
