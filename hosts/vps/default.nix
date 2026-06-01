{ pkgs, ... }:

{
  imports = [
    ../../modules/bundle.nix
  ];
  ssh.enable = true;

  networking.hostName = "vps";
}
