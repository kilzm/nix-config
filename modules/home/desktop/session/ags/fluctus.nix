{inputs, ...}: {
  perSystem = {
    pkgs,
    lib,
    system,
    ...
  }: let
    agsPkgs = inputs.ags.packages.${system};
    extraPackages =
      (with agsPkgs; [
        astal4
        io
        network
        bluetooth
        hyprland
        notifd
        tray
        wireplumber
        apps
        mpris
        battery
      ])
      ++ (with pkgs; [libadwaita libsoup_3]);

    package = pkgs.stdenv.mkDerivation {
      name = "fluctus";
      src = ./fluctus;

      nativeBuildInputs = with pkgs;
        [
          wrapGAppsHook3
          gobject-introspection
        ]
        ++ [agsPkgs.ags];

      buildInputs = extraPackages ++ [pkgs.gjs];

      installPhase = ''
        mkdir -p $out/{bin,share}
        cp -r assets/* $out/share
        ags bundle app.ts $out/bin/fluctus -d "ASSETS='$out/share'"

        cat > $out/bin/fluctus-request <<'EOF'
        #!/usr/bin/env bash
        ${lib.getExe agsPkgs.ags} request -i "fluctus-shell" "$@"
        EOF

        cat > $out/bin/fluctus-quit <<'EOF'
        #!/usr/bin/env bash
        ${lib.getExe agsPkgs.ags} quit -i "fluctus-shell" "$@"
        EOF

        chmod +x $out/bin/fluctus-request
        chmod +x $out/bin/fluctus-quit
      '';

      preFixup = ''
        gappsWrapperArgs+=(
          --prefix PATH : ${lib.makeBinPath (with pkgs; [
          libqalculate
          procps
        ])}
        )
      '';
    };
  in {
    packages.fluctus = package;

    devShells.fluctus = pkgs.mkShell {
      buildInputs = [
        (inputs.ags.packages.${system}.ags.override {
          inherit extraPackages;
        })
        pkgs.prettier
      ];
    };
  };
}
