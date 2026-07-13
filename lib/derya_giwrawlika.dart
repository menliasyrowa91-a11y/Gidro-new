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

  @override
  void dispose() {
    _bUstiController.dispose();
    _bAstyController.dispose();
    _hController.dispose();
    _lController.dispose();
    _tController.dispose();
    super.dispose();
  }

  void _calculate() {
    final bU = double.tryParse(_bUstiController.text);
    final bA = double.tryParse(_bAstyController.text);
    final h = double.tryParse(_hController.text);
    final l = double.tryParse(_lController.text);
    final t = double.tryParse(_tController.text);

    if (bU == null || bA == null || h == null || l == null || t == null || t == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hemme meýdanlary dogry dolduryň!")),
      );
      return;
    }

    // FORMULA LOGIKASY (kiçi harplar bilen düzedildi)
    final f = ((bU + bA) / 2) * h;
    const k = 0.82;
    final v = (l / t) * k;
    final q = f * v;

    setState(() {
      _fResult = f.toStringAsFixed(2);
      _vResult = v.toStringAsFixed(2);
      _qResult = q.toStringAsFixed(3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text("Derýa Gidrawlika Hasaby", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              
              TextField(controller: _bUstiController, decoration: const InputDecoration(labelText: "Suw üsti ini (b_usti)"), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
              TextField(controller: _bAstyController, decoration: const InputDecoration(labelText: "Suw asty ini (b_asty)"), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
              TextField(controller: _hController, decoration: const InputDecoration(labelText: "Çuňluk (h)"), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
              TextField(controller: _lController, decoration: const InputDecoration(labelText: "Aralyk (L)"), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
              TextField(controller: _tController, decoration: const InputDecoration(labelText: "Wagt (t)"), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
              
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
                      const Text("Netijeler:", style: TextStyle(fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
