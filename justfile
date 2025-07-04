#!/usr/bin/env just --justfile

build:
  colmena build

apply:
  colmena apply

build-vm host="bengal":
  nixos-rebuild build-vm --flake .#{{host}}

create-new-hcloud-host name="" type="cx11" location="nbg1":
  hcloud server create --name '{{name}}' --type 'cx22' --image debian-11 --user-data-from-file files/cloud-init.yml --location nbg1 --ssh-key openpgp:0x6068FEBB --network cherrykitten-internal

delete-hcloud-host name="":
  hcloud server delete '{{name}}'

git:
  nix fmt
  git add .

update-secrets:
  git commit secrets -m "update secrets"
