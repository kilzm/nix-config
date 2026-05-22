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
        mkAbbr = suffix: mkEntry:
          {
            d = "develop";
            s = "shell";
            b = "build";
            r = "run";
          }
          |> lib.mapAttrs' (
            n: v:
              lib.nameValuePair
              "n${n}${suffix}"
              (mkEntry "nix ${v}" // {position = "command";})
          );
      in
        mkAbbr "" (v: {
          expansion = v;
        })
        // mkAbbr "." (v: {
          cursor = true;
          expansion = "${v} .#%";
        })
        // mkAbbr "n" (v: {
          cursor = true;
          expansion = "${v} nixpkgs#%";
        });

      gitAbbreviations = let
        mkAbbr = cmds:
          cmds
          |> lib.mapAttrs' (
            n: v:
              lib.nameValuePair "g${n}" {
                position = "command";
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
          c = "commit";
          ca = "commit --amend";
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
          lib.nameValuePair
          (lib.replicate (n + 1) "." |> lib.concatStrings)
          (lib.replicate n ".." |> lib.concatStringsSep "/"))
        |> lib.listToAttrs;

      ltAbbreviations =
        lib.range 1 9
        |> map (n:
          lib.nameValuePair "lt${toString n}" {
            expansion = "lt -L ${toString n}";
            position = "command";
          })
        |> lib.listToAttrs;

      mkCmd = cmds:
        cmds
        |> lib.mapAttrs (_: v: {
          position = "command";
          expansion = v;
        });
    in
      mkCmd {
        c = "clear";
        e = "yazi";
        cp = "cp -vi";
        mv = "mv -vi";
      }
      // ltAbbreviations
      // nixAbbreviations
      // gitAbbreviations
      // dotAbbreviations;
  };
}
