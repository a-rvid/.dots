{ pkgs, ... }:

let
  # pam_mount calls mount.fuse -> su user -> gocryptfs, and the resulting
  # PATH does not include /run/wrappers/bin, so go-fuse picks up the
  # un-setuid fusermount from the fuse store path and the kernel rejects
  # the mount. Prepend the wrappers dir so the setuid fusermount wins. Thanks claude, was difficult
  gocryptfsForPam = pkgs.writeShellScriptBin "gocryptfs" ''
    export PATH=/run/wrappers/bin:$PATH
    exec ${pkgs.gocryptfs}/bin/gocryptfs "$@"
  '';
in
{
  environment.systemPackages = with pkgs; [
    git
    vim
    wl-clipboard
    libfido2
    gocryptfs
    btop
    stow
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
          mountpoint="/home/user/.crypt"
          path="${gocryptfsForPam}/bin/gocryptfs#/home/user/.dots/encrypt"
          options="nodev,nosuid,quiet"
          user="user"
        />
      ''
    ];
    createMountPoints = true;
  };

  security.pam.services = let
    runLoginScript = {
      order = 20000;
      control = "optional";
      modulePath = "${pkgs.pam}/lib/security/pam_exec.so";
      args = [ "seteuid" "/home/user/.dots/scripts/login.sh" ];
    };
  in {
    login.rules.session.run_login_script = runLoginScript;
    ly.rules.session.run_login_script = runLoginScript;
  };

  systemd.user.services.crypt-mount = {
    enable = true;
    description = "Create mount point for gocryptfs";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''/run/current-system/sw/bin/ mkdir -p /home/user/.crypt'';
      User = "user";
      Group = "users";
    };
  };

  services = {
    # tor = {
    #   enable = true;
    #   client.dns.enable = true;
    #   client.enable = true;
    #   settings.ControlPort = 9051;
    #   settings.DNSPort = [{
    #     addr = "127.0.0.1";
    #     port = 53;
    #   }];
    # };
    resolved = {
      enable = true; # For caching DNS requests.
      fallbackDns = [ "" ]; # Overwrite compiled-in fallback DNS servers.
    };
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
