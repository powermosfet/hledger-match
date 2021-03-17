let
  pkgs = import <nixpkgs> { };

in
pkgs.haskellPackages.callPackage ./hledger-match.nix { }
