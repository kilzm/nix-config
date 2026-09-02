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
        |> lib.mapAttrs (
          _: v: "${lib.getExe self'.packages.eza} ${v}"
        );
    in
      ezaAliases;

    abbreviations = let
      nixAbbreviations = let
        mkAbbr = c: extra:
          {
            d = "develop";
            s = "shell";
            b = "build";
            r = "run";
          }
          |> lib.concatMapAttrs (n: v: let
            mkEntry = expansion: {
              inherit expansion;
              cursor = true;
            };
          in {
            "n${n}${c}" = mkEntry "nix ${v} ${extra}%";
            "n${n}${c}u" = mkEntry "NIXPKGS_ALLOW_UNFREE=1 nix ${v} --impure ${extra}%";
          });
      in
        mkAbbr "" " "
        // mkAbbr "." ".#"
        // mkAbbr "n" "nixpkgs#"
        // mkAbbr "g" "github:"
        // mkAbbr "f" "git+file://"
        // mkAbbr "p" "path:"
        // mkAbbr "l" "gitlab:";

      gitAbbreviations = let
        mkAbbr = cmds:
          cmds
          |> lib.mapAttrs' (
            n: v:
              lib.nameValuePair "g${n}" {
                cursor = true;
                expansion = "git ${v}";
              }
          );
      in
        mkAbbr {
          "" = "%";
          d = "diff";
          s = "status --short";
          l = "log --oneline";
          a = "add";
          aa = "add --all";
          c = "commit";
          ca = "commit --amend";
          can = "commit --amend --no-edit";
          cm = ''commit -m \"%\"'';
          p = "push";
          u = "pull";
          f = "fetch";
          r = "reset";
          ru = "reset --staged";
          rh = "reset --hard";
          rs = "reset --soft";
          r1 = "reset HEAD~1";
          co = "checkout";
          cb = "checkout -b";
          m = "merge";
          i = "init";
          cl = "clone";
          st = "stash";
          sta = "stash apply";
          stp = "stash push";
          stpm = ''stash push -m \"%\"'';
          sto = "stash pop";
          std = "stash drop";
          sts = "stash show -p";
        };

      dotAbbreviations =
        lib.range 1 5
        |> map (n:
          lib.nameValuePair (lib.replicate (n + 1) "." |> lib.concatStrings) {
            expansion = lib.replicate n ".." |> lib.concatStringsSep "/";
            position = "anywhere";
          })
        |> lib.listToAttrs;

      ltAbbreviations =
        lib.range 1 9
        |> map (n: lib.nameValuePair "lt${toString n}" "lt -L ${toString n}")
        |> lib.listToAttrs;
    in
      {
        c = "clear";
        e = "yazi";
        cp = "cp -vi";
        mv = "mv -vi";
        lg = "lazygit";
      }
      // ltAbbreviations
      // nixAbbreviations
      // gitAbbreviations
      // dotAbbreviations;
  };
}
