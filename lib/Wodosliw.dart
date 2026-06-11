import 'package:flutter/material.dart';
import 'dart:math';

class Wodosliw extends StatefulWidget {
  const Wodosliw({super.key});

  @override
  State<Wodosliw> createState() => _WodosliwState();
}

class _WodosliwState extends State<Wodosliw> {
  final TextEditingController _bController = TextEditingController(text: '0.5');
  final TextEditingController _hController = TextEditingController(text: '0.09');
  final TextEditingController _meydanController = TextEditingController(text: '1');
  final TextEditingController _normaController = TextEditingController(text: '800');
  final TextEditingController _ptkController = TextEditingController(text: '0.85');

  String? _qLSek;
  String? _wagtSagat;
  String? _jemiSuwBrutto;

  void _calculate() {
    final valB = double.tryParse(_bController.text);
    final valH = double.tryParse(_hController.text);
    final valM = double.tryParse(_meydanController.text);
    final valNorma = double.tryParse(_normaController.text);
    final valPtk = double.tryParse(_ptkController.text);

    if (valB == null || valH == null || valM == null || valNorma == null || valPtk == null) {
      showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text("Ýalňyşlyk"), content: const Text("Hemme sanlary dogry giriziň!"), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))]));
      return;
    }

    // Q = 1.86 * b * H^1.5 (l/s-e öwürmek üçin * 1000)
    final qLSek = (1.86 * valB * pow(valH, 1.5)) * 1000;
    final qM3Sek = qLSek / 1000;

    // Jemi suw (m3) = (meýdan * norma) / ptk
    final jemiSuwBrutto = (valM * valNorma) / valPtk;

    // Wagt (sekunt) = Jemi suw / Q_m3_sek
    final wagtSek = jemiSuwBrutto / qM3Sek;
    final wagtSagat = wagtSek / 3600;

    setState(() {
      _qLSek = qLSek.toStringAsFixed(2);
      _wagtSagat = wagtSagat.toStringAsFixed(2);
      _jemiSuwBrutto = jemiSuwBrutto.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Wodosliw Hasaby", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(controller: _bController, decoration: const InputDecoration(labelText: "Wodosliw ini (b)"), keyboardType: TextInputType.number),
            TextField(controller: _hController, decoration: const InputDecoration(labelText: "Suw beýikligi (H)"), keyboardType: TextInputType.number),
            TextField(controller: _meydanController, decoration: const InputDecoration(labelText: "Meýdan (ga)"), keyboardType: TextInputType.number),
            TextField(controller: _normaController, decoration: const InputDecoration(labelText: "Suw norma"), keyboardType: TextInputType.number),
            TextField(controller: _ptkController, decoration: const InputDecoration(labelText: "PTK (0.85)"), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669), foregroundColor: Colors.white),
              child: const Text("HASAPLA"),
            ),
            if (_qLSek != null)
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: const Color(0xFFf0fdf4), borderRadius: BorderRadius.circular(8)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sekuntda alnan suw: $_qLSek l/sek"),
                    Text("Jemi suw (Brutto): $_jemiSuwBrutto m³"),
                    Text("Hakyky suwaryş wagty: $_wagtSagat sagat", style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
