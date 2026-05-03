{
  config,
  ...
}:
let
  mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

  mkExtensionSettings = builtins.mapAttrs (
    _: entry: {
      install_url = entry;
      installation_mode = "force_installed";
    }
  );
in
{
  home = {
    sessionVariables = {
      BROWSER = "zen";
      MOZ_LEGACY_PROFILES = 1;
    };
  };

  programs.zen-browser = {
    enable = true;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DontCheckDefaultBrowser = true;
      DisablePocket = true;
      DisableAppUpdate = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      ExtensionSettings = mkExtensionSettings {
        "uBlock0@raymondhill.net" = mkPluginUrl "ublock-origin";
        "moz-addon-prod@7tv.app" = mkPluginUrl "7tv-extension";
        "{a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad}" = mkPluginUrl "refined-github-";
        "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = mkPluginUrl "github-file-icons";
        "github-no-more@ihatereality.space" = mkPluginUrl "github-no-more";
        "github-repository-size@pranavmangal" = mkPluginUrl "gh-repo-size";
        "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = mkPluginUrl "return-youtube-dislikes";
        "firefox-extension@steamdb.info" = mkPluginUrl "steam-database";
        "{74145f27-f039-47ce-a470-a662b129930a}" = mkPluginUrl "clearurls";
        "@searchengineadremover" = mkPluginUrl "searchengineadremover";
        "jid1-BoFifL9Vbdl2zQ@jetpack" = mkPluginUrl "decentraleyes";
        "trackmenot@mrl.nyu.edu" = mkPluginUrl "trackmenot";
        "zotero@chnm.gmu.edu" = "https://www.zotero.org/download/connector/dl?browser=firefox";
      };
    };

    profiles.kilianm = {
      name = "kilianm";

      search = {
        force = true;
        default = "ddg";
      };

      settings = {
        "zen.urlbar.replace-newtab" = false;
        "xpinstall.signatures.required" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.tabs.allow_transparent_browser" = true;
        "widget.transparent-windows" = true;
        "zen.widget.linux.transparency" = true;
        "gfx.webrender.compositor.force-enabled" = true;
      };

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
          position = 105;
        };
      };

      userChrome =
        let
          color = "rgba(20, 20, 20, 0.85)";
        in
        ''
          * {
            font-family: ${config.theming.fonts.sans};
          }
          .zen-browser-generic-background {
            --zen-themed-toolbar-bg: ${color} !important;
            --toolbar-bgcolor: ${color} !important;
            --toolbox-bgcolor-inactive: ${color} !important;
            --zen-main-browser-background: ${color} !important;
            --newtab-background-color: ${color} !important;
            --lwt-sidebar-background-color: ${color} !important;
          }
        '';

      mods = [
        "253a3a74-0cc4-47b7-8b82-996a64f030d5" # floating history
        "fd24f832-a2e6-4ce9-8b19-7aa888eb7f8e" # quietify
      ];
    };
  };
}
