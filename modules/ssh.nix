{ config, lib, pkgs, ... }:

let
  publicKey = ''
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOYflayqclaYClYzK2VpBNNnvTDYQqyyPuFvwL2ywcn8
  '';
in
{
  options = {
    ssh.enable = 
      lib.mkEnableOption "enables ssh conf";
  };

  config = lib.mkIf config.ssh.enable {
    users.users.user = {
      openssh.authorizedKeys.keys = [ publicKey ];
    };

    services.openssh.enable = true;
    services.openssh.passwordAuthentication = false;
    services.openssh.permitRootLogin = "no";
    services.openssh.extraConfig = ''
      PubkeyAuthentication yes
      PermitEmptyPasswords no
    '';
  };
}
