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
    String? çeşme,
    int? dowamlylykGijeGundiz,
    int? dowamlylyk,
  }) : this.cesme = cesme ?? çeşme ?? "...",
       this.dowamlylykGijeGundiz = dowamlylykGijeGundiz ?? dowamlylyk ?? 0;
}
