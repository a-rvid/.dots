# usbguard.nix
{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  cfg = config.custom.security.usbguard;
in {
  options.custom.security.usbguard = {
    enable = lib.mkEnableOption "usbguard";
  };

  config = mkIf cfg.enable {
    services.usbguard = {
      enable = true;
      IPCAllowedUsers = ["root" "your-user"];
    # presentDevicePolicy refers to how to treat USB devices that are already connected when the daemon starts
      presentDevicePolicy = "allow";
      rules = ''
        # allow `only` devices with mass storage interfaces (USB Mass Storage)
        allow with-interface equals { 08:*:* }
        # allow mice and keyboards
        # allow with-interface equals { 03:*:* }

        # Reject devices with suspicious combination of interfaces
        reject with-interface all-of { 08:*:* 03:00:* }
        reject with-interface all-of { 08:*:* 03:01:* }
        reject with-interface all-of { 08:*:* e0:*:* }
        reject with-interface all-of { 08:*:* 02:*:* }
      '';
    };

    environment.systemPackages = [pkgs.usbguard];
  };
}
