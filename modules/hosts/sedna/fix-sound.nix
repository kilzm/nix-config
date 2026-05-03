{
  flake.nixosModules.sedna = {pkgs, ...}: {
    systemd.services.fix-sof-sound = {
      description = "Unmute sof-essx8336 channels";
      wantedBy = ["multi-user.target"];
      after = ["sound.target" "alsa-restore.service"];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = "root";
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
      };
      script = let
        amixer = "${pkgs.alsa-utils}/bin/amixer";
        card = "sofessx8336";
        cset = "${amixer} -c ${card} cset";
        sset = "${amixer} -c ${card} sset";
      in ''
        ${cset} name='Speaker Switch' on
        ${cset} name='Headphone Playback Volume' 3,3
        ${cset} name='Left Headphone Mixer Left DAC Switch' on
        ${cset} name='Right Headphone Mixer Right DAC Switch' on
        ${cset} name='DAC Playback Volume' 999,999
        ${cset} name='Headphone Mixer Volume' 999,999
        ${sset} Headphone 3
      '';
    };
    environment.systemPackages = [pkgs.alsa-utils];
  };
}
