class Ekin {
  final String ady;
  final int jemiNorma; // EkinBazasyndan
  final double jemiBaha; // EkinBazasyndan
  final List<Tapgyr> tapgyrlar; // Tablisadan

  Ekin({
    required this.ady,
    required this.jemiNorma,
    required this.jemiBaha,
    required this.tapgyrlar,
  });
}

class Tapgyr {
  final String ady;
  final int normaM3;
  final double gidroModul;
  final double baha;
  final String mohlet;
  final String çeşme;
  final int dowamlylykGijeGundiz;

  Tapgyr({
    required this.ady,
    required this.normaM3,
    required this.gidroModul,
    required this.baha,
    required this.mohlet,
    required this.çeşme,
    required this.dowamlylykGijeGundiz,
  });
}
