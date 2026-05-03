{
  flake.homeModules.zen-browser = {
    programs.zen-browser = {
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
        ExtensionSettings = let
          mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

          mkExtensionSettings = builtins.mapAttrs (
            _: entry: {
              install_url = entry;
              installation_mode = "force_installed";
            }
          );
        in
          mkExtensionSettings {
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
    };
  };
}
