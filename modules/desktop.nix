{ config, inputs, lib, pkgs, ... }:

{
  options = {
    desktop.enable =
      lib.mkEnableOption "enables desktop stuff";
  };

  config = lib.mkIf config.desktop.enable {
    home-manager.users.user.mango.enable = true;
    programs.dms-shell = {
      enable = true;

      # Core features
      enableSystemMonitoring = true;     # System monitoring widgets (dgop)
      enableVPN = true;                  # VPN management widget
      enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
      enableAudioWavelength = true;      # Audio visualizer (cava)
      enableCalendarEvents = true;       # Calendar integration (khal)
      enableClipboardPaste = true;       # Pasting from the clipboard history (wtype)
    };

    security.polkit.enable = true;

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
