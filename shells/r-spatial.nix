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
      udunits
    ];

  packages = with pkgs.rPackages;
    [
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
     buildInputs = sysdeps;
     packages = packages;
     LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
     LANG = "en_US.UTF-8";
     RENV_CONFIG_PAK_ENABLED = "TRUE";
    };
}
