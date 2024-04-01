#!/usr/bin/env just --justfile

build:
  colmena build

apply:
  colmena apply

build-vm host="bengal":
  nixos-rebuild build-vm --flake .#{{host}}

git:
  nix fmt
  git add .
