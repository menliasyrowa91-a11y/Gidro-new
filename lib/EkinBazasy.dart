import 'package:flutter/material.dart';

class Ekin {
  final String ady;
  final int norma;
  final double kpd;

  Ekin({required this.ady, required this.norma, required this.kpd});
}

class EkinBazasy extends StatefulWidget {
  const EkinBazasy({super.key});

  @override
  State<EkinBazasy> createState() => _EkinBazasyState();
}

class _EkinBazasyState extends State<EkinBazasy> {
  // Ekinleriň sanawy
  final List<Ekin> ekinler = [
    Ekin(ady: "Gowaça", norma: 2700, kpd: 0.85),
    Ekin(ady: "Bugdaý", norma: 1400, kpd: 0.80),
    Ekin(ady: "Mekgejöwen", norma: 800, kpd: 0.82),
    Ekin(ady: "Arpa", norma: 1200, kpd: 0.80),
    Ekin(ady: "Hyýar", norma: 900, kpd: 0.85),
  ];

  Ekin? _selectedEkin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Ekin Bazasy", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            // Ekinleri saýlamak üçin Dropdown
            DropdownButton<Ekin>(
              hint: const Text("Ekini saýlaň"),
              value: _selectedEkin,
              isExpanded: true,
              onChanged: (Ekin? newValue) {
                setState(() {
                  _selectedEkin = newValue;
                });
              },
              items: ekinler.map((Ekin ekin) {
                return DropdownMenuItem<Ekin>(
                  value: ekin,
                  child: Text(ekin.ady),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),
            
            // Saýlanan ekiniň maglumatyny görkezmek
            if (_selectedEkin != null)
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ady: ${_selectedEkin!.ady}", style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("Norma: ${_selectedEkin!.norma} m³/ga"),
                    Text("KPD: ${_selectedEkin!.kpd}"),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
