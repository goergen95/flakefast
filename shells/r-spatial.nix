{pkgs}:

let

  sysdeps = with pkgs;
    [
      arrow-cpp
      coreutils
      curl
      git
      geos
      gdal
      openssl
      proj
      R
    ];

  packages = with pkgs.rPackages;
    [
      codetools
      devtools
      gdalcubes
      gdalraster
      lwgeom
      rnaturalearth
      rstac
      s2
      sf
      stars
      terra
      tmap
    ];

   in
{
   r-spatial = pkgs.mkShell {
     name = "r-spatial dev shell";
     buildInputs = [sysdeps packages];
     LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
     LANG = "en_US.UTF-8";
    };
}
