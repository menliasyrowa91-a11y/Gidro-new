// lib/ekin_bazasy.dart (ýa-da faýlyňyzyň ady)
import 'package:flutter/material.dart';

// Ekin klassyny şeýle üýtgediň:
class Ekin {
  final String ady;
  final int norma;
  final double bahasy;

  Ekin({required this.ady, required this.norma, required this.bahasy});

  // Flutter-e iki ekinin deňdigini "ady" boýunça kesgitlemegi öwredýäris
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
    // ... beýleki ekinleriňiz
  ];

  final List<double> ptkList = [0.75, 0.78, 0.80, 0.82, 0.85, 0.90, 0.95];
  
  // Üýtgeşme: _selectedEkin-i nola deňläp goýsaňyz gowy
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
              // Ekinleri map edende her birine unique key bermek üçin (e, child: Text(e.ady))
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
            const SizedBox(height: 20),
            
            if (_selectedEkin != null && _selectedPtk != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ekin: ${_selectedEkin!.ady}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const Divider(),
                    Text("Norma: ${_selectedEkin!.norma} m³/ga"),
                    Text("Saýlanan PTK: $_selectedPtk"),
                    const SizedBox(height: 10),
                    Text(
                      "Jemi harajat: ${(_selectedEkin!.norma * _selectedEkin!.bahasy).toStringAsFixed(2)} manat",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green[900]),
                    ),
                    Text(
                      "Brutto suw möçberi: ${(_selectedEkin!.norma / _selectedPtk!).toStringAsFixed(2)} m³/ga",
                      style: TextStyle(color: Colors.blue[800], fontSize: 16),
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
