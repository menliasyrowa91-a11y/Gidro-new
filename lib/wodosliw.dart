// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart'; // Bu paket seneleri hasaplamak üçin hökmandyr

class Wodosliw extends StatefulWidget {
  const Wodosliw({super.key});

  @override
  State<Wodosliw> createState() => _WodosliwState();
}

class _WodosliwState extends State<Wodosliw> {
  // Giriş üçin kontrollerler
  final TextEditingController _startController = TextEditingController(text: '2026-06-12 10:00:00');
  final TextEditingController _endController = TextEditingController(text: '2026-06-13 08:00:00');
  final TextEditingController _bController = TextEditingController(text: '0.5');
  final TextEditingController _hController = TextEditingController(text: '0.048');
  final TextEditingController _meydanController = TextEditingController(text: '1');
  final TextEditingController _normaController = TextEditingController(text: '800');
  final TextEditingController _ptkController = TextEditingController(text: '0.85');

  // Netijeler üçin üýtgeýänler
  Map<String, String>? _res;

  void _calculate() {
    final valB = double.tryParse(_bController.text);
    final valH = double.tryParse(_hController.text);
    final valM = double.tryParse(_meydanController.text);
    final valNorma = double.tryParse(_normaController.text);
    final valPtk = double.tryParse(_ptkController.text);

    if (valB == null || valH == null || valM == null || valNorma == null || valPtk == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Ýalňyşlyk"),
          content: const Text("Hemme sanlary dogry giriziň!"),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))],
        ),
      );
      return;
    }

    // 1. Seneleri parse etmek (Excel logikasy üçin wagt tapawudy)
    DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime start = format.parse(_startController.text);
    DateTime end = format.parse(_endController.text);
    double hakykyWagtSagat = end.difference(start).inMinutes / 60.0;

    // 2. Hasaplamalar
    final qLSek = (1.86 * valB * pow(valH, 1.5)) * 1000;
    final qM3Sek = qLSek / 1000;
    
    final jemiSuwBrutto = (valM * valNorma) / valPtk;
    final jemiSuwNetto = (valM * valNorma);
    
    // Wagt hasaby (Excel formulasy boýunça)
    final wagtSek = jemiSuwBrutto / qM3Sek;
    final wagtSagat = wagtSek / 3600;
    
    // Netto wagt hasaby
    final wagtNettoSek = jemiSuwNetto / qM3Sek;
    final wagtNettoSagat = wagtNettoSek / 3600;

    // Aratapawut hasaby
    final aratapawut = jemiSuwBrutto - jemiSuwNetto;

    setState(() {
      _res = {
        "start": _startController.text,
        "end": _endController.text,
        "hakykyWagt": hakykyWagtSagat.toStringAsFixed(2),
        "b": valB.toStringAsFixed(1),
        "qLSek": qLSek.toStringAsFixed(2),
        "H": valH.toStringAsFixed(3),
        "meydan": valM.toString(),
        "norma": valNorma.toString(),
        "ptk": valPtk.toString(),
        "wagtSek": wagtSek.toStringAsFixed(2),
        "wagtSagat": wagtSagat.toStringAsFixed(2),
        "jemiBrutto": jemiSuwBrutto.toStringAsFixed(2),
        "jemiNetto": jemiSuwNetto.toStringAsFixed(2),
        "ortacaM3": jemiSuwBrutto.toStringAsFixed(2),
        "aratapawut": aratapawut.toStringAsFixed(2),
        "kadaBruttoWagt": wagtSagat.toStringAsFixed(2),
        "kadaNettoWagt": wagtNettoSagat.toStringAsFixed(2),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wodosliw Hasaby")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _startController, decoration: InputDecoration(labelText: "Başlanýan senesi we wagty:")),
            TextField(controller: _endController, decoration: InputDecoration(labelText: "Gutarýan senesi we wagty:")),
            TextField(controller: _bController, decoration: InputDecoration(labelText: "Wodasliwiň ini (b), metr")),
            TextField(controller: _hController, decoration: InputDecoration(labelText: "Bosagadan agýan suwuň beýikligi (H), metr")),
            TextField(controller: _meydanController, decoration: InputDecoration(labelText: "Jemi suwarlan meýdan, ga")),
            TextField(controller: _normaController, decoration: InputDecoration(labelText: "Bir gektara berilmeli suwuň möçberi (norma)")),
            TextField(controller: _ptkController, decoration: InputDecoration(labelText: "Ýabyň peýdaly iş koeffisienti (PTK)")),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669), foregroundColor: Colors.white),
              child: const Text("HASAPLA"),
            ),
            if (_res != null)
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: const Color(0xFFf0fdf4), borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Başlanýan: ${_res!['start']}"),
                    Text("Gutarýan: ${_res!['end']}"),
                    Text("Hakyky suw tutulan wagt: ${_res!['hakykyWagt']} sagat"),
                    Divider(),
                    Text("Wodasliwiň ini (b): ${_res!['b']} m"),
                    Text("Sekuntda alnan suw: ${_res!['qLSek']} l/sek"),
                    Text("Suw beýikligi (H): ${_res!['H']} m"),
                    Text("Jemi suwarlan meýdan: ${_res!['meydan']} ga"),
                    Text("Suw norma: ${_res!['norma']}"),
                    Text("PTK: ${_res!['ptk']}"),
                    Divider(),
                    Text("Suw tutmagyň dowamlylygy (sek): ${_res!['wagtSek']}"),
                    Text("Kada Brutto boýunça wagt: ${_res!['kadaBruttoWagt']} sagat"),
                    Text("Kada Netto boýunça wagt: ${_res!['kadaNettoWagt']} sagat"),
                    Divider(),
                    Text("Jemi suw (Brutto): ${_res!['jemiBrutto']} m³"),
                    Text("Jemi arassa suw (Netto): ${_res!['jemiNetto']} m³"),
                    Text("Aratapawudy: ${_res!['aratapawut']} m³"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
