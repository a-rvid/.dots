{ config, lib, pkgs, ... }:

{
  options = {
    dev.enable =
      lib.mkEnableOption "enables stuff needed for development";
  };

  config = lib.mkIf config.dev.enable {
    home-manager.users.user.dev.enable = true;
    preservation.preserveAt."/persistent".users.user = {
      directories = [ ".claude" ];
      files = [ ".claude.json" ];
    };
  };
}
