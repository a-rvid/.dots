{ pkgs, ... }:

{
  imports = [
    ../../modules/bundle.nix
  ];
  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-partlabel/disk-main-root";
    allowDiscards = true;
  };

  desktop.enable = true;
  macchanger = {
    enable = true;
    interface = "wlp2s0";
  };
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  messaging.enable = true;

  gaming = {
    enable = true;
    nvidia.enable = true;
  };
  dev.enable = true;
  networking.hostName = "nvidia";
  environment.systemPackages = [ pkgs.OVMF ];
}
