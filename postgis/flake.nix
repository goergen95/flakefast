{
  description = "A Nix flake template for a dev environment with a PostGIS server";

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
            sysdeps = with pkgs; [coreutils];
            postgis = pkgs.postgresql_17.withPackages (p: [ p.postgis ]);
          in {

          default = pkgs.mkShell {
            name = "postgis";
            buildInputs = [
                sysdeps
                postgis
                # https://github.com/toraritte/shell.nixes/blob/main/elixir-phoenix-postgres/shell.nix
                # https://elixirforum.com/t/flake-nix-phoenix-postgresql/52622
                (pkgs.writeShellScriptBin "pg-setup" ''
                    set -e
                    mkdir -p $PGDATA
                    pg_ctl initdb -D $PGDATA
                '')
                (pkgs.writeShellScriptBin "pg-reset" ''
                    pg-stop
                    rm -rf $PGDATA
                '')
                (pkgs.writeShellScriptBin "pg-stop" ''
                    pg_ctl -D $PGDATA -U postgres stop
                '')
                (pkgs.writeShellScriptBin "pg-console" ''
                    psql --host $PGDATA -U $USER postgres
                '')
                (pkgs.writeShellScriptBin "pg-start" ''
                    [ ! -d $PGDATA ] && pg-setup
                    pg_ctl                                                  \
                      -D $PGDATA                                            \
                      -l $PGDATA/postgres.log                               \
                      -o "-c unix_socket_directories='$PGDATA'"             \
                      start
                    psql -h $PGDATA -d postgres -c 'create extension if not exists postgis;'
                '')
            ];
            LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
            LANG = "en_US.UTF-8";
            shellHook = ''
                export PGDATA=$PWD/.postgres
            '';
            };
          });
  };
}
