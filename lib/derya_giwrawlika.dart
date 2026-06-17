// lib/derya_giwrawlika.dart
import 'package:flutter/material.dart';

class DeryaGiwrawlika extends StatefulWidget {
  const DeryaGiwrawlika({super.key});

  @override
  State<DeryaGiwrawlika> createState() => _DeryaGiwrawlikaState();
}

class _DeryaGiwrawlikaState extends State<DeryaGiwrawlika> {
  final TextEditingController _bUstiController = TextEditingController(text: '5.0');
  final TextEditingController _bAstyController = TextEditingController(text: '3.5');
  final TextEditingController _hController = TextEditingController(text: '1.2');
  final TextEditingController _lController = TextEditingController(text: '10');
  final TextEditingController _tController = TextEditingController(text: '15');

  String? _fResult;
  String? _vResult;
  String? _qResult;

  // San girizmek üçin optimizirlenen typ
  final TextInputType _numericType = const TextInputType.numberWithOptions(decimal: true);

  void _calculate() {
    final bU = double.tryParse(_bUstiController.text);
    final bA = double.tryParse(_bAstyController.text);
    final h = double.tryParse(_hController.text);
    final l = double.tryParse(_lController.text);
    final t = double.tryParse(_tController.text);

    // Wagt 0 ýa-da maglumat ýok bolsa duýduryş berýär
    if (bU == null || bA == null || h == null || l == null || t == null || t == 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Ýalňyşlyk"),
          content: const Text("Hemme meýdanlary dogry dolduryň we wagt 0 bolmaly däl!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
      return;
    }

    // FORMULA LOGIKASY:
    // 1. Meýdan (F) = ((b_usti + b_asty) / 2) * h
    final F = ((bU + bA) / 2) * h;
    
    // 2. Tizlik (V) = (L / t) * K (K = 0.82)
    const K = 0.82;
    final V = (l / t) * K;
    
    // 3. Suw sarpyny (Q) = F * V
    final Q = F * V;

    setState(() {
      _fResult = F.toStringAsFixed(2);
      _vResult = V.toStringAsFixed(2);
      _qResult = Q.toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Derýa Gidrawlika Hasaby", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            
            TextField(controller: _bUstiController, decoration: const InputDecoration(labelText: "Suw üsti ini (b_usti)"), keyboardType: _numericType),
            TextField(controller: _bAstyController, decoration: const InputDecoration(labelText: "Suw asty ini (b_asty)"), keyboardType: _numericType),
            TextField(controller: _hController, decoration: const InputDecoration(labelText: "Çuňluk (h)"), keyboardType: _numericType),
            TextField(controller: _lController, decoration: const InputDecoration(labelText: "Aralyk (L)"), keyboardType: _numericType),
            TextField(controller: _tController, decoration: const InputDecoration(labelText: "Wagt (t)"), keyboardType: _numericType),
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669), foregroundColor: Colors.white),
              child: const Text("HASAPLA"),
            ),
            
            if (_fResult != null)
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: const Color(0xFFf0fdf4), borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    const Text("Ulanylan formula:", style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
                    const Text("Q = [((bU+bA)/2)*h] * [(L/t)*0.82]", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                    const Divider(),
                    Text("Meýdan (F): $_fResult m²"),
                    Text("Tizlik (V): $_vResult m/s"),
                    Text("Suw sarpyny (Q): $_qResult m³/s", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF065f46))),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
