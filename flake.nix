{
  description = "A nix flake supplying R and Python dev environments and project templates";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

  outputs = {self, nixpkgs}:
  let
    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
      ];
    forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
      pkgs = import nixpkgs { inherit system; };
      });
  in {
    devShells = forAllSystems ({ pkgs }:
    let
      r-base = import ./shells/r-base.nix { inherit pkgs; };
      py-base = import ./shells/py-base.nix { inherit pkgs; };
      r-spatial = import ./shells/r-spatial.nix { inherit pkgs; };
      py-spatial = import ./shells/py-spatial.nix { inherit pkgs; };
    in {
      inherit (r-base) r-base;
      inherit (py-base) py-base;
      inherit (r-spatial) r-spatial;
      inherit (py-spatial) py-spatial;
      });

    templates = {
      r-base = {
        path = ./templates/r-base;
        description = "A Nix flake template for a r-base dev environment";
      };
      r-spatial = {
        path = ./templates/r-spatial;
        description = "A Nix flake template for a r-spatial dev environment";
      };
     py-base = {
        path = ./templates/py-base;
        description = "A Nix flake template for a py-base dev environment";
      };
      py-spatial = {
        path = ./templates/py-spatial;
        description = "A Nix flake template for a py-spatial dev environment";
      };

    };
  };
}
