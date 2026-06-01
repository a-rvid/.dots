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
    steam.enable = true;
    amd.enable = true;
    nvidia.enable = true;
  };
  dev.enable = true;
  home-manager.users.user.firefox.enable = true;
  services.hardware.deepcool-digital-linux.enable = true;
  services.flatpak.enable = true;
  
  networking.hostName = "legolas";

  desktop.enable = true;
  services.desktopManager.plasma6.enable = true;
  # Add legolas-specific configuration here
}
