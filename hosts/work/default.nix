{ pkgs, ... }:

{
  imports = [
    ../../modules/bundle.nix
  ];
  messaging.enable = true;
  dev.enable = true;
  
  networking.hostName = "work";
  desktop.enable = true;
}
