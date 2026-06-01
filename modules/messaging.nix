{ config, lib, pkgs, ... }:

{
  options = {
    messaging.enable = 
      lib.mkEnableOption "messaging apps";
  };

  config = lib.mkIf config.messaging.enable {
    environment.systemPackages = with pkgs; [
      signal-desktop
      gajim
      gnupg 
      openssl
      vesktop
    ];

    preservation.preserveAt."/persistent".users.user.directories = [
      ".config/Signal"
      ".config/vesktop"
      ".config/gajim"
    ];
  };
}
