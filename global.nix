{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    wl-clipboard
    libfido2
    gocryptfs
    usbutils
    pciutils
    nushell
  ];
  
  security.pam.mount = {
    enable = true;
    extraVolumes = [
      ''
        <volume
          fstype="fuse"
          mountpoint="/home/user/crypt"
          path="/usr/bin/gocryptfs#/home/user/.dots/encrypt"
          options="nodev,nosuid"
          user="user"
        />
      ''
    ];
    createMountPoints = true;
  };

  services.udev.packages = [ pkgs.libfido2 ];

  programs.git = {
    enable = true;
    config = {
      user.name = "a-rvid";
      user.email = "git@rvid.eu";
      
      core.editor = "nvim";
      merge.tool = "nvim -d";
    };
  };

  environment.sessionVariables = rec {
    EDITOR = "nvim";
  };
}
