{ pkgs, ... }:

{
  imports = [
    ../../modules/bundle.nix
  ];
  firefox.enable = true;
  nixvim.enable  = true; 
  messaging.enable = true;
  dev.enable = true;
  hardware.bluetooth.enable = true;
  
  networking.hostName = "work";

  desktop.enable = true;
  services.desktopManager.plasma6.enable = true;
}
