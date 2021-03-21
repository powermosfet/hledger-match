{ pkgs ? import <nixpkgs> { } }:

pkgs.haskellPackages.callPackage ./hledger-match.nix { }
