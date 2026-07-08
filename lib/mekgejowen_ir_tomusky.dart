// lib/mekgejowen_ir_tomusky.dart
import 'ekin_model.dart';

// Her bir normaM3-i 1.15-e köpeldip, 15% ýitgi marginini goşdum
final Ekin mekgejowenIrTomusky = Ekin(
  ady: "Mekgejöwen (ir tomusda)",
  tapgyrlar: [
    Tapgyr(ady: "Tagt suwy", normaM3: (1600 * 1.15).toInt(), gidroModul: 0.882, baha: 47.68, mohlet: "25.III-18.IV", çeşme: "Maglumat ýok", dowamlylykGijeGundiz: 21),
    Tapgyr(ady: "1-nji ösüş", normaM3: (800 * 1.15).toInt(), gidroModul: 0.651, baha: 23.84, mohlet: "7.VI-21.VI", çeşme: "Maglumat ýok", dowamlylykGijeGundiz: 16),
    Tapgyr(ady: "2-nji ösüş", normaM3: (1000 * 1.15).toInt(), gidroModul: 0.890, baha: 29.80, mohlet: "22.VI-1.VII", çeşme: "Maglumat ýok", dowamlylykGijeGundiz: 13),
    Tapgyr(ady: "3-nji ösüş", normaM3: (1100 * 1.15).toInt(), gidroModul: 1.061, baha: 32.78, mohlet: "2.VII-16.VII", çeşme: "Maglumat ýok", dowamlylykGijeGundiz: 12),
    Tapgyr(ady: "4-nji ösüş", normaM3: (1200 * 1.15).toInt(), gidroModul: 1.157, baha: 35.76, mohlet: "7.VII-21.VII", çeşme: "Maglumat ýok", dowamlylykGijeGundiz: 12),
    Tapgyr(ady: "5-nji ösüş", normaM3: (1200 * 1.15).toInt(), gidroModul: 1.068, baha: 35.76, mohlet: "22.VII-1.VIII", çeşme: "Maglumat ýok", dowamlylykGijeGundiz: 13),
    Tapgyr(ady: "6-njy ösüş", normaM3: (1100 * 1.15).toInt(), gidroModul: 0.749, baha: 32.78, mohlet: "2.VIII-16.VIII", çeşme: "Maglumat ýok", dowamlylykGijeGundiz: 17),
  ],
);
