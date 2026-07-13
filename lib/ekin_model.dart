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
  final List<Tapgyr> tapgyrlar;

  int get jemiNorma => tapgyrlar.fold(0, (sum, item) => sum + item.normaM3);
  double get jemiBaha => tapgyrlar.fold(0.0, (sum, item) => sum + item.baha);

  Ekin({required this.ady, required this.tapgyrlar});

  @override
  bool operator ==(Object other) => other is Ekin && other.ady == ady;
  
  @override
  int get hashCode => ady.hashCode; 
}
