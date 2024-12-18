{pkgs}:

let

  sys_deps = with pkgs;
    [
      arrow-cpp
      git
      geos
      gdal
      pandoc
      proj
      quarto
      R
      texliveMinimal
    ];

  r_pkgs= with pkgs.rPackages;
    [
      devtools
      exactextractr
      furrr
      future
      gdalcubes
      gdalraster
      glue
      httr2
      knitr
      lwgeom
      mirai
      progressr
      remotes
      rmarkdown
      rnaturalearth
      rnaturalearthhires
      rstac
      rsi
      s2
      sf
      stars
      targets
      tarchetypes
      terra
      testthat
      tidymodels
      tidyverse
      tmap
      usethis
      waywiser
    ];

  rnaturalearthhires = pkgs.rPackages.buildRPackage {
    name = "rnaturalearthhires";
      src = pkgs.fetchFromGitHub{
        owner = "ropensci";
        repo = "rnaturalearthhires";
        rev = "db8e433bfb80dc775f04bd5b0d8911fa6b9a568c";
        sha256 = "89kO4fkyN6qj/zTTkZwpEtcil8umEm3u0oCzMtV3EAk=";
        };
      nativeBuildInputs = with pkgs.rPackages; [sp];
   };
   in
{
   rspatial = pkgs.mkShell {
     name = "RSpatial";
     buildInputs = sys_deps;
     packages = r_pkgs;
     LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
     LANG = "en_US.UTF-8";
    };
}
