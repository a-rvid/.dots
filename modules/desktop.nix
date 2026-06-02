{ config, lib, pkgs, ... }:

{
  options = {
    desktop.enable = 
      lib.mkEnableOption "enables display management";
  };

  config = lib.mkIf config.desktop.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animate = true;
        animation = "gameoflife"; 
        clock = "%c";
        bigclock = true;
      };
    };

    services.flatpak.enable = true;

    preservation.preserveAt."/persistent".users.user.directories = [
      "Documents"
      "Videos"
      "Projects"
      ".local/state/wireplumber"
      ".local/state/pipewire"
      ".config/pulse"
      ".config/wireplumber"
      ".local/share/flatpak"
    ];

    preservation.preserveAt."/persistent" = {
      directories = [
        "/var/lib/flatpak"
      ];
    };
  };
}
