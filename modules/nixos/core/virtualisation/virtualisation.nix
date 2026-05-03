{
  flake.nixosModules.virtualisation = {pkgs, ...}: {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
    users.extraGroups.docker.members = ["kilianm"];

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
      };
    };
    users.extraGroups.libvirtd.members = ["kilianm"];
    programs.virt-manager.enable = true;
  };
}
