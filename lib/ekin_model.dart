// lib/ekin_model.dart

class Tapgyr {
  final String ady;
  final int normaM3;
  final double gidroModul;
  final double baha;
  final String mohlet;
  final String cesme;
  final int dowamlylykGijeGundiz;

  Tapgyr({
    required this.ady,
    required this.normaM3,
    required this.gidroModul,
    required this.baha,
    required this.mohlet,
    String? cesme,
    int? dowamlylykGijeGundiz,
  })  : this.cesme = cesme ?? "...",
        this.dowamlylykGijeGundiz = dowamlylykGijeGundiz ?? 0;

  Map<String, dynamic> toMap() {
    return {
      'ady': ady,
      'normaM3': normaM3,
      'gidroModul': gidroModul,
      'baha': baha,
      'mohlet': mohlet,
      'cesme': cesme,
      'dowamlylykGijeGundiz': dowamlylykGijeGundiz,
    };
  }

  @override
  String toString() {
    return 'Tapgyr(ady: $ady, norma: $normaM3, cesme: $cesme)';
  }
}

class Ekin {
  final String ady;
  final List<Tapgyr> tapgyrlar;

  Ekin({required this.ady, required this.tapgyrlar});
}
