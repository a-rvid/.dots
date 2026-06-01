{ pkgs, ... }:

{
  imports = [
    ../../modules/bundle.nix
  ];
  firefox.enable = true;
  nixvim.enable  = true; 
  messaging.enable = true;
  gaming = {
    enable = true;
    nvidia.enable = true;
  };
  dev.enable = true;
  home-manager.users.user.firefox.enable = true;
  hardware.bluetooth.enable = true;
  
  networking.hostName = "nvidia";

  desktop.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = [
    pkgs.cage
  ];
}
