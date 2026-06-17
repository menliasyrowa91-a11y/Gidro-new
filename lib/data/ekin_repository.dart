// lib/data/ekin_repository.dart
import '../ekin_model.dart'; // Hökman import etmeli!
import '../gowaca.dart';
import '../bugday.dart';
import '../arpa.dart';
import '../mekgejowen_siloslyk.dart';
import '../mekgejowen_ir_tomusky.dart';
import '../mekgejowen_yazlyk.dart';
import '../pomidor.dart';
import '../hyyar.dart';
import '../sogan.dart';
import '../kelem.dart';
import '../kashir.dart';
import '../sarymsak.dart';
import '../bakja.dart';
import '../miweli_baglar.dart';
import '../uzum.dart';
import '../yeralma.dart';
import '../aralyk_ekinler.dart';
import '../yorunja_kopyyllyk.dart';
import '../yorunja_yazlyk.dart';

class EkinRepository {
  static List<Ekin> get allEkinler => [
    gowacaData,
    bugdayData,
    arpaData,
    mekgejowenSiloslyk, // Siziň faýlyňyzda 'mekgejowenSiloslyk' ady bilen bellenildi
    mekgejowenIrTomusky, // Siziň faýlyňyzda 'mekgejowenIrTomusky' ady bilen bellenildi
    mekgejowenYazlyk,   // Siziň faýlyňyzda 'mekgejowenYazlyk' ady bilen bellenildi
    pomidorData,
    hyyarData,
    soganData,
    kelemData,
    kashirData,
    sarymsakData,
    bakjaData,
    miweliBaglarData,
    uzumData,
    yeralmaKartoşkaData,
    aralykEkinlerData,
    yorunjaKopyyllykData,
    yorunjaYazlykData,
  ];
}
