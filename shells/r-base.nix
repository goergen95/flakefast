{pkgs}:

let

  sysdeps = with pkgs;
    [
      coreutils
      R
    ];

  packages = with pkgs.rPackages; [ ];
   in
{
   r-base = pkgs.mkShell {
     name = "r-base dev shell";
     buildInputs = sysdeps;
     packages = packages;
     LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
     LANG = "en_US.UTF-8";
    };
}
