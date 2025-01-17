{
  description = "A Nix flake template with the Positron IDE";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }:
    let
      # supported systems
      systems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # helper function for system-spefcific packages
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true;};
      });

    in {
       devShells = forAllSystems ({ pkgs }:
         let
            sysdeps = with pkgs;
              [
                coreutils
                bashInteractive
                positron-bin
              ];

          in {

          default = pkgs.mkShell {
            name = "positron";
            buildInputs = [sysdeps];
            inputsFrom = sysdeps;
            };
          });
  };
}
