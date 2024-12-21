## nix-flakes

This repo provides custom development environments based on Nix flakes.

### Nix installation

To install [Nix](https://nixos.org/download/):

```bash
sh <(curl -L https://nixos.org/nix/install) --no-daemon
```

Then to enable [Flakes](https://nixos.wiki/wiki/Flakes) for your user:

```bash
mkdir -p ~/.config/nix && echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

### Usage

You can investigate what is available via:

```bash
nix flake show "github:goergen95/nix-flakes"
```

To drop into a shell with a basic installation of R:

```bash
nix develop "github:goergen95/nix-flakes#r-base"
```

You can also automatically enable a R spatial dev environment directly from 
GitHub when `cd`ing into the project directory via [direnv](https://direnv.net/):

```bash
echo "use flake \"github:goergen95/nix-flakes#r-spatial\"" >> .envrc && direnv allow
```

By adding additional references we can be compose our project environment from
multiple ones:

```bash
echo "use flake \"github:goergen95/nix-flakes#py-spatial\"" >> .envrc && direnv allow
```

Alternativley, templates can be fetched to the project directory to manually customize 
the project environment:

```bash
nix flake init -t "github:goergen95/nix-flakes#py-spatial"
echo "use flake" >> .envrc && direnv allow
```


