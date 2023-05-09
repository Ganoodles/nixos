{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = with pkgs.buildPackages; [ 
      # python
      python310Packages.pip
      python310Packages.pytesseract
      python310Packages.aiosqlite
      python310Packages.appdirs
      python310Packages.pytimeparse

      # linting
      python310Packages.black
      python310Packages.pylint
      python310Packages.mypy

      python310Full 
      python310Packages.pip 
      python310Packages.pytesseract
      poetry
    ];
  }
