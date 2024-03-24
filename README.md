This repository includes my NixOS and Home-manager configurations.

The repo is organized as follows:
```
.
├── flake.lock
├── flake.nix
├── hosts # NixOS-configurations
│   ├── bengal # Host-specific
│   │   ├── default.nix
│   │   └── hardware-configuration.nix
│   ├── common # General, imported by all hosts
│   │   ├── default.nix
│   │   ├── graphical.nix
│   │   ├── security.nix
│   │   ├── users.nix
│   │   ├── virtualization.nix
│   │   └── yubikey.nix
├── misc # just some stuff 
├── modules # Home-manager and NixOS modules that follow upstream standards, currently empty lol
│   ├── home
│   └── nixos
└── users # Home-Manager configurations
    ├── common # General, imported by all
    ├── sammy.nix # User-specific, but not Host-specific
    └── sammy@chansey.nix User- and Host-specific
```
