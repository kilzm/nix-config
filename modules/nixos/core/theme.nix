{inputs, ...}: {
  flake.nixosModules.core = {lib, ...}: {
    imports = [inputs.stylix.nixosModules.stylix];
    stylix = {
      enable = true;
      base16Scheme = {
        scheme = "nordfox-base16";
        base00 = "141414";
        base01 = "1a1a1a";
        base02 = "252525";
        base03 = "465780";
        base04 = "8cafd2";
        base05 = "cdcecf";
        base06 = "e5e9f0";
        base07 = "e7ecf4";
        base08 = "bf616a";
        base09 = "c9826b";
        base0A = "ebcb8b";
        base0B = "a3be8c";
        base0C = "88c0d0";
        base0D = "81a1c1";
        base0E = "b48ead";
        base0F = "6b3030";
      };
      polarity = "dark";
      opacity = lib.genAttrs ["terminal" "applications" "desktop" "popups"] (_: 0.85);
      autoEnable = false;
    };
  };
}
