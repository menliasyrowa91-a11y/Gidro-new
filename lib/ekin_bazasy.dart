// ignore_for_file: illegal_character
import 'package:flutter/material.dart';

class Ekin {
  final String ady;
  final int norma;
  final double bahasy;

  Ekin({required this.ady, required this.norma, required this.bahasy});

  @override
  bool operator ==(Object other) => other is Ekin && other.ady == ady;
  @override
  int get hashCode => ady.hashCode;
}

class EkinBazasy extends StatefulWidget {
  const EkinBazasy({super.key});

  @override
  State<EkinBazasy> createState() => _EkinBazasyState();
}

class _EkinBazasyState extends State<EkinBazasy> {
  final List<Ekin> ekinler = [
    Ekin(ady: "Gowaça", norma: 7000, bahasy: 0.0298),
    Ekin(ady: "Bugdaý", norma: 5300, bahasy: 0.0298),
    Ekin(ady: "Şaly", norma: 30000, bahasy: 0.0298),
    Ekin(ady: "Mekgejöwen", norma: 8100, bahasy: 0.0298),
    Ekin(ady: "Arpa", norma: 5300, bahasy: 0.0298),
    Ekin(ady: "Pomidor", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Hyýar", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Sogan", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Kelem", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Käşir", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Sarymsak", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Badamjan", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Burç", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Ispanak", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Turp", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Gyzyl şugundyr", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Bozbaş", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Noýba", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Ýer şugundyry", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Garry gara", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Kädi", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Garpyz", norma: 12600, bahasy: 0.0298),
    Ekin(ady: "Gawun", norma: 12600, bahasy: 0.0298),
  ];

  final List<double> ptkList = [0.75, 0.78, 0.80, 0.82, 0.85, 0.90, 0.95];
  Ekin? _selectedEkin;
  double? _selectedPtk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ekin Bazasy")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            DropdownButtonFormField<Ekin>(
              decoration: const InputDecoration(labelText: "Ekini saýlaň", border: OutlineInputBorder()),
              value: _selectedEkin,
              isExpanded: true,
              onChanged: (Ekin? newValue) => setState(() => _selectedEkin = newValue),
              items: ekinler.map((e) => DropdownMenuItem(value: e, child: Text(e.ady))).toList(),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<double>(
              decoration: const InputDecoration(labelText: "Ýabyň PTK-syny saýlaň", border: OutlineInputBorder()),
              value: _selectedPtk,
              isExpanded: true,
              onChanged: (double? newValue) => setState(() => _selectedPtk = newValue),
              items: ptkList.map((val) => DropdownMenuItem(value: val, child: Text(val.toString()))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
