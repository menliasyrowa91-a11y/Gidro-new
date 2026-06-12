// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

/* * Düzüji: Meňli Aşyrowa 
 */

import 'package:flutter/material.dart';
import 'dart:math';

class Yapgidrawlika extends StatefulWidget {
  const Yapgidrawlika({super.key});

  @override
  State<Yapgidrawlika> createState() => _YapgidrawlikaState();
}

class _YapgidrawlikaState extends State<Yapgidrawlika> {
  String type = 'acyk';
  final TextEditingController _bController = TextEditingController(text: '0.50');
  final TextEditingController _hController = TextEditingController(text: '0.15');
  final TextEditingController _dController = TextEditingController(text: '300');
  final TextEditingController _vController = TextEditingController(text: '0.9');
  String _result = '0.000';

  final Map<String, double> tabelaF = {
    "300": 0.07,
    "400": 0.12,
    "500": 0.19,
    "600": 0.28,
    "700": 0.38,
    "800": 0.50,
    "900": 0.63,
    "1000": 0.78
  };

  void _calculate() {
    double q = 0;

    if (type == 'acyk') {
      final valB = double.tryParse(_bController.text);
      final valH = double.tryParse(_hController.text);
      if (valB == null || valH == null) {
        _showError("Dogry san giriziň!");
        return;
      }
      q = 1.86 * valB * pow(valH, 1.5);
    } else {
      final valV = double.tryParse(_vController.text);
      final f = tabelaF[_dController.text];
      if (f == null || valV == null) {
        _showError("Diametr ýa-da tizlik nädogry!");
        return;
      }
      q = f * valV;
    }
    setState(() {
      _result = q.toStringAsFixed(3);
    });
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Ýalňyşlyk"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Ýap Gidrawlika Hasaby",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => setState(() => type = type == 'acyk' ? 'yapyk' : 'acyk'),
              style: ElevatedButton.styleFrom(
                backgroundColor: type == 'acyk' ? Colors.blue : Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              child: Text(type == 'acyk' ? "Režim: Açyk Ýap" : "Režim: Turba (Ýapyk)"),
            ),
            const SizedBox(height: 20),
            if (type == 'acyk') ...[
              TextField(
                controller: _bController,
                decoration: const InputDecoration(labelText: "Wodosliw ini (b)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _hController,
                decoration: const InputDecoration(labelText: "Suw gatlagy (H)"),
                keyboardType: TextInputType.number,
              ),
            ] else ...[
              TextField(
                controller: _dController,
                decoration: const InputDecoration(labelText: "Diametr (mm: 300-1000)"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _vController,
                decoration: const InputDecoration(labelText: "Tizlik (m/s)"),
                keyboardType: TextInputType.number,
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
                foregroundColor: Colors.white,
              ),
              child: const Text("HASAPLA"),
            ),
            const SizedBox(height: 20),
            Text(
              "Netije: $_result m³/s",
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF1e3a8a),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
