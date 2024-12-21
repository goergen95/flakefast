{
  description = "A Nix flake template for a py-spatial dev environment";

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
                arrow-cpp
                coreutils
                curl
                git
                geos
                gdal
                openssl
                proj
                python311
              ];

            packages = with pkgs.python311Packages;
              [
                boto3
                cartopy
                dask
                fiona
                fsspec
                gdal
                geopandas
                jupyter-core
                numpy
                pyproj
                rasterio
                xarray
                zarr
              ];

          in {

          default = pkgs.mkShell {
            buildInputs = [sysdeps packages];
            LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
            LANG = "en_US.UTF-8";
            };
          });
  };
}
