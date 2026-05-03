{
  flake.homeModules.zen-browser = {
    programs.zen-browser.profiles.default.mods = [
      "253a3a74-0cc4-47b7-8b82-996a64f030d5" # floating history
      "fd24f832-a2e6-4ce9-8b19-7aa888eb7f8e" # quietify
    ];
  };
}
