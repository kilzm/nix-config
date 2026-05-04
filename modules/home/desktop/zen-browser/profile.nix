{
  flake.homeModules.zen-browser = {
    programs.zen-browser.profiles.default = {
      id = 0;
      search = {
        force = true;
        default = "ddg";
      };

      settings = {
        "zen.urlbar.replace-newtab" = false;
        "xpinstall.signatures.required" = false;
      };

      keyboardShortcuts = [
        {
          id = "zen-compact-mode-toggle";
          key = "c";
          modifiers = {
            control = true;
            alt = true;
          };
        }
        {
          id = "zen-toggle-sidebar";
          key = "x";
          modifiers = {
            control = true;
            alt = true;
          };
        }
      ];

      pinsForce = true;
      pins = {
        "YouTube" = {
          id = "85ccc93e-0f0e-480f-a8a3-9ca920ba23dd";
          url = "https://www.youtube.com/";
          isEssential = true;
          position = 101;
        };
        "Twitch" = {
          id = "6365ba0f-13ec-42db-a226-3a008eaabd50";
          url = "https://www.twitch.tv/";
          isEssential = true;
          position = 102;
        };
        "GitHub" = {
          id = "513b6b63-1e22-44d0-9911-73a0667d17e4";
          url = "https://www.github.com/";
          isEssential = true;
          position = 103;
        };
        "GMail" = {
          id = "e136ab84-d240-491b-81a7-9a7e91add84d";
          url = "https://mail.google.com/";
          isEssential = true;
          position = 104;
        };
        "TUM Moodle" = {
          id = "0be2ec7a-152e-4b44-8e83-ed9ee7b5a12c";
          url = "https://www.moodle.tum.de/";
          isEssential = true;
          position = 105;
        };
        "TUMonline" = {
          id = "a13c49eb-6ee2-44de-9150-7edf6916240e";
          url = "https://campus.tum.de/tumonline/";
          isEssential = true;
          position = 106;
        };
      };
    };
  };
}
