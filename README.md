# confnix -- my nixos config files

These are the configuration file for some of my
[NixOs](http://nixos.org) installations.

## Setup

    cd /etc/nixos
    git clone https://github.com/eikek/confnix
    ln -s confnix/systems/some-conf.nix configuration.nix
    nixos-rebuild switch



## Credits

Aside from the nix/nixpgs manuals, I got inspired by other
configuration setups:

- https://github.com/aszlig/vuizvui
- https://github.com/chaoflow/nixos-configurations
