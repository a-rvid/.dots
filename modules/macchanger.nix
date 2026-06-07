{ config, lib, pkgs, ... }:

{
  options = {
    mac-changer.enable = 
      lib.mkEnableOption "enables automatic macchanger";
    mac-changer.interface = lib.mkOption "Interface";
  };

  config = lib.mkIf config.mac-changer.enable {
    packages.mac-changer.enable = true;
    systemd.services."macchanger" = {
      description = "Changes MAC";
      wants = [ "network-pre.target" ];
      wantedBy = [ "multi-user.target" ];
      before = [ "network-pre.target" ];
      bindsTo = [ "sys-subsystem-net-devices-wlp3s0.device" ];
      after = [ "sys-subsystem-net-devices-wlp3s0.device" ];
      script = ''
        ${pkgs.macchanger}/bin/macchanger -b ${config.mac-changer.interface}
      '';
      serviceConfig.Type = "oneshot";
  };
}
