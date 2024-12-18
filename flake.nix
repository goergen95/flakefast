{
  description = "Main flake";
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
      rspatialShell = import ./rspatial.nix { inherit pkgs; };
    in {
      inherit (rspatialShell) rspatial;
      } // {
       default = pkgs.mkShell{
        packages = with pkgs; [ bashInteractive ];
    };
    });
  };
}
