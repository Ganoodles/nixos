#!/bin/sh
pushd ~/.nix
home-manager switch -f ./users/noodle/home.nix
popd
