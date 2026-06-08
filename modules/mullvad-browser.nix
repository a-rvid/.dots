{ config, lib, pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.mullvad-browser
  ];
  # home-manager.users.user.firefox.enable = true;
  preservation.preserveAt."/persistent".users.user.directories = [
      ".mullvad"
  ];
}
