{ config, lib, pkgs, ... }:

{
  options = {
    dev.enable =
      lib.mkEnableOption "enables stuff needed for development";
  };

  config = lib.mkIf config.dev.enable {
    virtualisation.docker.enable = true;
    users.extraGroups.docker.members = [ "user" ];
    home-manager.users.user.dev.enable = true;
    preservation.preserveAt."/persistent".users.user = {
      directories = [
        ".claude"
        ".rustup"
        ".cargo"
      ];
      files = [ ".claude.json" ];
    };
  };
}
