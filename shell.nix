{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = [
      pkgs.cabal2nix
      pkgs.cabal-install
    ];

  shellHook = ''
    LOCALE_ARCHIVE="$(nix-build --no-out-link '<nixpkgs>' -A glibcLocales)/lib/locale/locale-archive"
    export LANG=en_GB.UTF-8
  '';
}
