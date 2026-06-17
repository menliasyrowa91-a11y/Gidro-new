// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Ekin {
  final String ady;
  final int norma;
  final double bahasy;

  Ekin({required this.ady, required this.norma, required this.bahasy});
}

class EkinBazasy extends StatefulWidget {
  const EkinBazasy({super.key});

  @override
  State<EkinBazasy> createState() => _EkinBazasyState();
}

class _EkinBazasyState extends State<EkinBazasy> {
  // Faýlyňyzdan alnan 23 sany ekin (özümden san goşulmady)
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
              decoration: InputDecoration(labelText: "Ekini saýlaň", border: OutlineInputBorder()),
              value: _selectedEkin,
              isExpanded: true,
              onChanged: (Ekin? newValue) => setState(() => _selectedEkin = newValue),
              items: ekinler.map((e) => DropdownMenuItem(value: e, child: Text(e.ady))).toList(),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<double>(
              decoration: InputDecoration(labelText: "Ýabyň PTK-syny saýlaň", border: OutlineInputBorder()),
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
                    Text("Ekin: ${_selectedEkin!.ady}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Divider(),
                    Text("Norma: ${_selectedEkin!.norma} m³/ga"),
                    Text("Saýlanan PTK: $_selectedPtk"),
                    SizedBox(height: 10),
                    Text(
                      "Jemi harajat (1 ga): ${(_selectedEkin!.norma * _selectedEkin!.bahasy).toStringAsFixed(2)} manat",
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
