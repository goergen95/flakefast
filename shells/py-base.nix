{pkgs}:

let

  sysdeps = with pkgs;
    [
      coreutils
      python311
    ];

  packages= with pkgs.python311Packages; [ ];
   in
{
   py-base = pkgs.mkShell {
     name = "py-base dev shell";
     buildInputs = sysdeps;
     packages = packages;
     LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
     LANG = "en_US.UTF-8";
    };
}
