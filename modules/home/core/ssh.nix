{
  flake.homeModules.ssh = {
    services.ssh-agent.enable = true;
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;

      settings = {
        tunnel = {
          HostName = "login.dos.cit.tum.de";
          User = "tunnel";
        };

        graham = {
          HostName = "graham.dos.cit.tum.de";
          User = "markl";
          ForwardAgent = true;
          ProxyJump = "tunnel";
        };

        "*" = {
          AddKeysToAgent = true;
          Compression = false;
          ServerAliveInterval = 0;
          ServerAliveCountMax = 3;
          HashKnownHosts = false;
          UserKnownHostsFile = "~/.ssh/known_hosts";
          ControlMaster = "no";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "no";
        };
      };
    };
  };
}
