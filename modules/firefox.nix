{ config, lib, pkgs, ... }:

{
  options = {
    firefox.enable = 
      lib.mkEnableOption "enables firefox";
  };

  config = lib.mkIf config.firefox.enable {
    home-manager.users.user.firefox.enable = true;
    preservation.preserveAt."/persistent".users.user.directories = [
      ".mozilla"
    ];
  };
}
