{
  boot.tmp.cleanOnBoot = true;
  preservation = {
    enable = true;

    preserveAt."/persistent" = {
      directories = [
        "/etc/nixos"
        "/var/lib/bluetooth"
        "/etc/NetworkManager/system-connections"
        {
          directory = "/tmp";
          mode      = "1777";
          user      = "root";
          group     = "root";
        }
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
      ];

      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];

      # Preserve user files
      users.user = {
        directories = [
          ".ssh"
          ".dots"
        ];
      };
    };
  };
}
