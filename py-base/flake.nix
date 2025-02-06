{
  description = "A Nix flake template for a py-base dev environment";

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
        pkgs = import nixpkgs { inherit system; };
      });

    in {
       devShells = forAllSystems ({ pkgs }:
         let
            sysdeps = with pkgs;
              [
                coreutils
              ];

            packages =  with pkgs; [
              (python3.withPackages (ps: with ps;
                [
                ]))
             # (python3Packages.buildPythonPackage {
             #   pname = "name";
             #   version = "0.0.0";
             #   src = python3Packages.fetchPypi {
             #     pname = "name";
             #     version = "0.0.0";
             #     sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
             #   };
             # })
            ];

          in {

          default = pkgs.mkShell {
            name = "py-base";
            buildInputs = [sysdeps packages];
            inputsFrom = sysdeps;
            LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
            LANG = "en_US.UTF-8";
            };
          });
  };
}
