{ mkDerivation, base, hledger-lib, relude, stdenv, text }:
mkDerivation {
  pname = "hledger-match";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base hledger-lib relude text ];
  executableHaskellDepends = [ base relude ];
  testHaskellDepends = [ base ];
  homepage = "https://github.com/powermosfet/hledger-match#readme";
  license = stdenv.lib.licenses.bsd3;
}
