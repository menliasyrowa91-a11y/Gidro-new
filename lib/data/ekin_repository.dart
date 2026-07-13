// lib/data/ekin_repository.dart
import '../ekin_model.dart'; 
import '../gowaca_data.dart'; // Gowaça faýlyňyzyň adyny şeýle diýip üýtgediň
import '../bugday.dart';
import '../arpa.dart';
import '../mekgejowen_siloslyk.dart';
import '../mekgejowen_tomusky.dart';
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
        gowacaRegion1,        // Gowaça 1
        gowacaRegion2,        // Gowaça 2
        bugdayData,           
        arpaData,          
        mekgejowenSiloslykData, 
        mekgejowenTomuskyData,
        mekgejowenYazlykData,
        pomidorData,
        hyyarData,
        soganData,
        kelemData,
        kashirData,
        sarymsakData,
        bakjaData,
        miweliBaglarData,
        uzumData,
        yeralmaData,
        aralykEkinlerData,
        yorunjaKopyyllykData,
        yorunjaYazlykData,
      ];
}
