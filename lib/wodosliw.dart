// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//lib/wodosliw.dart
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class Wodosliw extends StatefulWidget {
  const Wodosliw({super.key});

  @override
  State<Wodosliw> createState() => _WodosliwState();
}

class _WodosliwState extends State<Wodosliw> {
  final TextEditingController _startController = TextEditingController(text: '2026-06-12 10:00:00');
  final TextEditingController _endController = TextEditingController(text: '2026-06-13 08:00:00');
  final TextEditingController _bController = TextEditingController(text: '0.5');
  final TextEditingController _hController = TextEditingController(text: '0.048');
  final TextEditingController _meydanController = TextEditingController(text: '1');
  final TextEditingController _normaController = TextEditingController(text: '800');
  final TextEditingController _ptkController = TextEditingController(text: '0.85');

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

    try {
      DateFormat format = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateTime start = format.parse(_startController.text);
      DateTime end = format.parse(_endController.text);

      // GÜNI WE SAGADY DOLY HASABA ALMAK:
      Duration diff = end.difference(start);
      double hakykyWagtSagat = diff.inSeconds / 3600.0;

      // Hasaplamalar
      final qLSek = (1.86 * valB * pow(valH, 1.5)) * 1000;
      final qM3Sek = qLSek / 1000;
      
      final jemiSuwBrutto = (valM * valNorma) / valPtk;
      final jemiSuwNetto = (valM * valNorma);
      
      final wagtSagatBrutto = jemiSuwBrutto / (qM3Sek * 3600);
      final wagtSagatNetto = jemiSuwNetto / (qM3Sek * 3600);

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
          "kadaBruttoWagt": wagtSagatBrutto.toStringAsFixed(2),
          "kadaNettoWagt": wagtSagatNetto.toStringAsFixed(2),
          "jemiBrutto": jemiSuwBrutto.toStringAsFixed(2),
          "jemiNetto": jemiSuwNetto.toStringAsFixed(2),
          "aratapawut": aratapawut.toStringAsFixed(2),
        };
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Senäniň formaty ýalňyş!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wodosliw Hasaby")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _startController, decoration: InputDecoration(labelText: "Başlanýan (yyyy-MM-dd HH:mm:ss)")),
            TextField(controller: _endController, decoration: InputDecoration(labelText: "Gutarýan (yyyy-MM-dd HH:mm:ss)")),
            TextField(controller: _bController, decoration: InputDecoration(labelText: "Wodasliwiň ini (b), metr"), keyboardType: TextInputType.number),
            TextField(controller: _hController, decoration: InputDecoration(labelText: "Suwuň beýikligi (H), metr"), keyboardType: TextInputType.number),
            TextField(controller: _meydanController, decoration: InputDecoration(labelText: "Suwarlan meýdan, ga"), keyboardType: TextInputType.number),
            TextField(controller: _normaController, decoration: InputDecoration(labelText: "Suw normasy"), keyboardType: TextInputType.number),
            TextField(controller: _ptkController, decoration: InputDecoration(labelText: "PTK (0-1 aralygynda)"), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, child: const Text("HASAPLA")),
            if (_res != null) ...[
              const Divider(height: 40),
              Text("Hakyky suw tutulan wagt: ${_res!['hakykyWagt']} sagat"),
              Text("Kada Brutto boýunça: ${_res!['kadaBruttoWagt']} sagat"),
              Text("Kada Netto boýunça: ${_res!['kadaNettoWagt']} sagat"),
              const Divider(),
              Text("Jemi suw (Brutto): ${_res!['jemiBrutto']} m³"),
              Text("Jemi arassa suw (Netto): ${_res!['jemiNetto']} m³"),
              Text("Aratapawudy: ${_res!['aratapawut']} m³"),
            ]
          ],
        ),
      ),
    );
  }
}
