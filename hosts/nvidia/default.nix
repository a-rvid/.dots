{ pkgs, ... }:

{
  imports = [
    ../../modules/bundle.nix
  ];
  macchanger = {
    enable = true;
    interface = "wlp2s0";
  };
  firefox.enable = true;
  nixvim.enable  = true; 
  messaging.enable = true;
  gaming = {
    enable = true;
    nvidia.enable = true;
  };
  dev.enable = true;
  home-manager.users.user.firefox.enable = true;
  home-manager.users.user.sway.enable = true;
  hardware.bluetooth.enable = true;
  environment.systemPackages = with pkgs; [ prismlauncher ];

  preservation.preserveAt."/persistent".users.user.directories = [
    ".local/share/PrismLauncher"
  ];
  
  networking.hostName = "nvidia";

  desktop.enable = true;
}
