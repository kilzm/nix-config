{
  flake.modules.fish.default = {
    lib,
    self',
    ...
  }: {
    shellAliases = let
      eza = lib.getExe self'.packages.eza;
    in {
      ls = "${eza}";
      ll = "${eza} -l";
      la = "${eza} -a";
      lla = "${eza} -la";
      lt = "${eza} --tree";
    };

    abbreviations = let
      nixcmds = {
        nd = "nix develop";
        ns = "nix shell";
        nb = "nix build";
        nr = "nix run";
      };

      simple = nixcmds |> builtins.mapAttrs (k: v: "${v}");

      local =
        nixcmds
        |> lib.mapAttrs' (k: v: {
          name = "${k}.";
          value = {
            cursor = true;
            expansion = "${v} .#%";
          };
        });

      nixpkgs =
        nixcmds
        |> lib.mapAttrs' (k: v: {
          name = "${k}n";
          value = {
            cursor = true;
            expansion = "${v} nixpkgs#%";
          };
        });

      nix-abbreviations = simple // local // nixpkgs;

      git-abbreviations = {
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
        lg = "lazygit";
      };
    in
      nix-abbreviations
      // git-abbreviations
      // {
        c = "clear";
        e = "yazi";
      };
  };
}
