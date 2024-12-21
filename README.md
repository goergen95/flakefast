## nix-flakes

This repo provides some custom development environments based on Nix flakes.

You can investigate what is available via:

```bash
nix flake show "github:goergen95/nix-flakes"
```

To drop into a shell with e.g. r-spatial packages:

```bash
nix develop "github:goergen95/nix-flakes#r-spatial"
```

To use a Python spatial template for your project and activate it automatically 
when `cd`ing into the project directory:

```bash
nix flake init -t "github:goergen95/nix-flakes#py-spatial"
echo "use flake" >> .envrc && direnv allow
```
