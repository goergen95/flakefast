{pkgs}:

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

  packages= with pkgs.python311Packages;
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
   in
{
   py-spatial = pkgs.mkShell {
     name = "py-spatial dev shell";
     buildInputs = sysdeps;
     packages = packages;
     LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
     LANG = "en_US.UTF-8";
    };
}
