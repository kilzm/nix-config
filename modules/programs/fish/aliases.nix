{
  flake.modules.fish.default = {
    lib,
    self',
    ...
  }: {
    shellAliases = let
      ezaAliases =
        {
          ls = "";
          ll = "-l";
          la = "-a";
          lla = "-la";
          lt = "--tree";
        }
        |> lib.mapAttrs (_: v: "${lib.getExe self'.packages.eza} ${v}");
    in
      {}
      // ezaAliases;

    abbreviations = let
      nixAbbreviations = let
        simple = {
          nd = "nix develop";
          ns = "nix shell";
          nb = "nix build";
          nr = "nix run";
        };

        local =
          simple
          |> lib.mapAttrs' (n: v:
            lib.nameValuePair "${n}." {
              cursor = true;
              expansion = "${v} .#%";
            });

        nixpkgs =
          simple
          |> lib.mapAttrs' (n: v:
            lib.nameValuePair "${n}n" {
              cursor = true;
              expansion = "${v} nixpkgs#%";
            });
      in
        simple // local // nixpkgs;

      gitAbbreviations = {
        gd = "git diff";
        ga = "git add";
        gc = "git commit";
        gp = "git push";
        gu = "git pull";
        gr = "git rebase";
        gf = "git fetch";
        gco = "git checkout";
        gcb = "git checkout -b";
        gm = "git merge";
        gs = "git status --short";
        gi = "git init";
        gcl = "git clone";
        gst = "git stash";
        gsta = "git stash apply";
        gstp = "git stash pop";
        gstd = "git stash drop";
        gsts = "git stash show -p";
        gl = "git log --all --graph --pretty=format:\\\"%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n\\\"";
      };
    in
      {
        c = "clear";
        e = "yazi";
      }
      // nixAbbreviations
      // gitAbbreviations;
  };
}
