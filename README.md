## nix-flakes

This repo provides some custom development environments based on Nix flakes.

You can investigate what is available via:

```bash
nix flake show "github:goergen95/nix-flakes"
```

To start e.g. an environment with R-Spatial packages run:

```bash
nix develop "github:goergen95/nix-flakes#rspatial"
```
