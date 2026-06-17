// lib/ekin_model.dart

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

class Ekin {
  final String ady;
  final int jemiNorma;
  final double jemiBaha;
  final List<Tapgyr> tapgyrlar;

  Ekin({
    required this.ady,
    this.jemiNorma = 0,
    this.jemiBaha = 0.0,
    required this.tapgyrlar,
  });
}
