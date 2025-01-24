{
  description = "A nix flake supplying R and Python dev environments and project templates";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {self, nixpkgs, flake-utils}:
  flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {

      devShells =
        let
          r-base = (import ./r-base/flake.nix).outputs {inherit self; inherit nixpkgs;};
          py-base = (import ./py-base/flake.nix).outputs {inherit self; inherit nixpkgs;};
          r-spatial = (import ./r-spatial/flake.nix).outputs {inherit self; inherit nixpkgs;};
          py-spatial = (import ./py-spatial/flake.nix).outputs {inherit self; inherit nixpkgs;};
          quarto = (import ./quarto/flake.nix).outputs {inherit self; inherit nixpkgs;};
          positron = (import ./positron/flake.nix).outputs {inherit self; inherit nixpkgs;};
          postgis = (import ./postgis/flake.nix).outputs {inherit self; inherit nixpkgs;};
        in {
          r-base = r-base.devShells.${system}.default;
          py-base = py-base.devShells.${system}.default;
          r-spatial = r-spatial.devShells.${system}.default;
          py-spatial = py-spatial.devShells.${system}.default;
          quarto = quarto.devShells.${system}.default;
          positron = positron.devShells.${system}.default;
          postgis = postgis.devShells.${system}.default;
          };

        }) // {

        templates = {
          r-base = {
            path = ./r-base;
            description = "A Nix flake template for a r-base dev environment";
          };
          r-spatial = {
            path = ./r-spatial;
            description = "A Nix flake template for a r-spatial dev environment";
          };
          py-base = {
            path = ./py-base;
            description = "A Nix flake template for a py-base dev environment";
          };
          py-spatial = {
            path = ./py-spatial;
            description = "A Nix flake template for a py-spatial dev environment";
          };
          quarto = {
            path = ./quarto;
            description = "A Nix flake template for an dev environment containing quarto";
          };
          positron = {
            path = ./positron;
            description = "A Nix flake template with the Positron IDE";
          };
          postgis = {
            path = ./postgis;
            description = "A Nix flake template with PostGIS";
          };
        };

      };
}
