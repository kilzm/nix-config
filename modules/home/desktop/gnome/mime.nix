{
  flake.homeModules.gnome = {lib, ...}: {
    xdg.mimeApps.defaultApplications = let
      image = [
        "image/bmp"
        "image/gif"
        "image/jpeg"
        "image/jpg"
        "image/pjpeg"
        "image/png"
        "image/tiff"
        "image/webp"
        "image/x-bmp"
        "image/x-gray"
        "image/x-icb"
        "image/x-ico"
        "image/x-png"
        "image/x-portable-anymap"
        "image/x-portable-bitmap"
        "image/x-portable-graymap"
        "image/x-portable-pixmap"
        "image/x-xbitmap"
        "image/x-xpixmap"
        "image/x-pcx"
        "image/svg+xml"
        "image/svg+xml-compressed"
        "image/vnd.wap.wbmp"
        "image/x-icns"
      ];
      video = [
        "video/mp4"
        "video/x-matroska"
        "video/webm"
        "video/quicktime"
        "video/x-msvideo"
        "video/mpeg"
        "video/ogg"
        "video/x-flv"
      ];
    in
      {
        "application/pdf" = ["org.gnome.Papers.desktop"];
        "inode/directory" = ["org.gnome.Nautilus.desktop"];
      }
      // lib.genAttrs image (_: ["org.gnome.Loupe.desktop"])
      // lib.genAttrs video (_: ["org.gnome.Showtime.desktop"]);
  };
}
