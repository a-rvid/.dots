{ pkgs, ... }:

{
  imports = [
    ../../modules/bundle.nix
  ];
  desktop.enable = true;
  macchanger = {
    enable = true;
    interface = "wlp2s0";
  };
  
  messaging.enable = true;
  
  gaming = {
    enable = true;
    nvidia.enable = true;
  };
  dev.enable = true;
  networking.hostName = "nvidia";
}
