// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

/* * Düzüji: Meňli Aşyrowa 
 */

import 'package:flutter/material.dart';

class Deryagidrawlika extends StatefulWidget {
  const Deryagidrawlika({super.key});

  @override
  State<Deryagidrawlika> createState() => _DeryagidrawlikaState();
}

class _DeryagidrawlikaState extends State<Deryagidrawlika> {
  final TextEditingController _bUstiController = TextEditingController(text: '5.0');
  final TextEditingController _bAstyController = TextEditingController(text: '3.5');
  final TextEditingController _hController = TextEditingController(text: '1.2');
  final TextEditingController _lController = TextEditingController(text: '10');
  final TextEditingController _tController = TextEditingController(text: '15');

  String? _fResult;
  String? _vResult;
  String? _qResult;

  void _calculate() {
    final bU = double.tryParse(_bUstiController.text);
    final bA = double.tryParse(_bAstyController.text);
    final h = double.tryParse(_hController.text);
    final l = double.tryParse(_lController.text);
    final t = double.tryParse(_tController.text);

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

    final F = ((bU + bA) / 2) * h;
    const K = 0.82;
    final V = (l / t) * K;
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
            const Text(
              "Derýa Gidrawlika Hasaby",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _bUstiController,
              decoration: const InputDecoration(labelText: "Suw üsti ini (b_usti)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _bAstyController,
              decoration: const InputDecoration(labelText: "Suw asty ini (b_asty)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _hController,
              decoration: const InputDecoration(labelText: "Çuňluk (h)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _lController,
              decoration: const InputDecoration(labelText: "Aralyk (L)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _tController,
              decoration: const InputDecoration(labelText: "Wagt (t)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
                foregroundColor: Colors.white,
              ),
              child: const Text("HASAPLA"),
            ),
            if (_fResult != null)
              Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFf0fdf4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text("Meýdan (F): $_fResult m²"),
                    Text("Tizlik (V): $_vResult m/s"),
                    Text(
                      "Suw sarpyny (Q): $_qResult m³/s",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF065f46),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
