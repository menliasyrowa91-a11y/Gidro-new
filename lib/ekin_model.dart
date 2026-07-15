// lib/ekin_model.dart
class Tapgyr {
  final String ady;
  final int normaM3;
  final double gidroModul;
  final double baha;
  final String mohlet;
  final String cesme; 
  final int dowamlylykGijeGundiz; 

  // Köne atlary hem kabul edýän konstruktor:
  Tapgyr({
    required this.ady,
    required this.normaM3,
    required this.gidroModul,
    required this.baha,
    required this.mohlet,
    required String cesme, 
    String? çeşme, // Köne ady ýumşak görnüşde kabul edýär
    required int dowamlylykGijeGundiz,
    int? dowamlylyk, // Köne ady ýumşak görnüşde kabul edýär
  }) : this.cesme = cesme ?? çeşme!, 
       this.dowamlylykGijeGundiz = dowamlylykGijeGundiz ?? dowamlylyk!;
}
