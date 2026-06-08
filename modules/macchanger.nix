{ config, lib, pkgs, ... }:

{
  options = {
    macchanger.enable = 
      lib.mkEnableOption "enables automatic macchanger";
    macchanger.interface = lib.mkOption { default = "eth0"; };
  };

  config = lib.mkIf config.macchanger.enable {
    environment.systemPackages = [
      pkgs.macchanger
    ];
    systemd.services."macchanger" = {
      description = "Changes MAC";
      wants = [ "network-pre.target" ];
      wantedBy = [ "multi-user.target" ];
      before = [ "network-pre.target" ];
      bindsTo = [ "sys-subsystem-net-devices-wlp3s0.device" ];
      after = [ "sys-subsystem-net-devices-wlp3s0.device" ];
      script = ''
        ${pkgs.macchanger}/bin/macchanger --random -b ${config.macchanger.interface}
      '';
      serviceConfig.Type = "oneshot";
    };
  };
}
