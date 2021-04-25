{ mkDerivation, base, hledger-lib, lib, relude, text }:
mkDerivation {
  pname = "hledger-match";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base hledger-lib relude text ];
  executableHaskellDepends = [ base relude text ];
  testHaskellDepends = [ base relude ];
  homepage = "https://github.com/powermosfet/hledger-match#readme";
  license = lib.licenses.bsd3;
}
