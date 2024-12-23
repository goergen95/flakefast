## flakefast

The goal of `flakefast` is to provide streamlined access to reproducible 
and composable development environments for (spatial) data science projects 
based on Nix flakes. The composition of the environments very
much reflects my personal project requirements, so it might not
provide the same value to others as it does to me. However, this 
project also reflects very novice eyes on the Nix ecosystem, so in 
case you too are learning more about Nix you are invited to have 
a look around and provide feedback if you wish. 


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
nix flake show "github:goergen95/flakefast"
```

To drop into a shell with a basic installation of R:

```bash
nix develop "github:goergen95/flakefast#r-base"
```

You can also automatically enable a R spatial dev environment directly from 
GitHub when `cd`ing into the project directory via [direnv](https://direnv.net/):

```bash
echo "use flake \"github:goergen95/flakefast#r-spatial\"" >> .envrc && direnv allow
```

By adding additional references we can be compose our project environment from
multiple ones:

```bash
echo "use flake \"github:goergen95/flakefast#py-spatial\"" >> .envrc && direnv allow
```

Alternativley, templates can be fetched to the project directory to manually customize 
the project environment:

```bash
nix flake init -t "github:goergen95/flakefast#py-spatial"
echo "use flake" >> .envrc && direnv allow
```


### Code of conduct

Please not that participation in this project is governed by a [Code of Conduct](./CODE_OF_CONDUCT.md)
and that by contributing you agree to abide by its terms.
