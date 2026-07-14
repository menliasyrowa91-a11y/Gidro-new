// ignore_for_file: illegal_character
//lib/turba_geciriji.dart
import 'package:flutter/material.dart';
class TurbaGeciriji extends StatefulWidget {
  const TurbaGeciriji({super.key});
 @override
  State<TurbaGeciriji> createState() => _TurbaGecirijiState();
}
class _TurbaGecirijiState extends State<TurbaGeciriji> {
  String _selectedDiametr = "300 mm";
  double _selectedBurc = 0.0;

  final Map<String, Map<double, double>> _tabloData = {
    "300 mm": {0.0: 0.0, 0.1: 0.0205, 0.2: 0.0501, 0.3: 0.0706},
    "400 mm": {0.0: 0.0, 0.1: 0.0245, 0.2: 0.0628, 0.3: 0.1011, 0.4: 0.1256},
    "500 mm": {0.0: 0.0, 0.1: 0.0277, 0.2: 0.0732, 0.3: 0.1230, 0.4: 0.1685, 0.5: 0.1962},
    "600 mm": {0.0: 0.0, 0.1: 0.0305, 0.2: 0.0821, 0.3: 0.1413, 0.4: 0.2005, 0.5: 0.2521, 0.6: 0.2826},
    "700 mm": {0.0: 0.0, 0.1: 0.0337, 0.2: 0.0907, 0.3: 0.1575, 0.4: 0.2270, 0.5: 0.2939, 0.6: 0.3509, 0.7: 0.3847},
    "800 mm": {0.0: 0.0, 0.1: 0.0362, 0.2: 0.0979, 0.3: 0.1715, 0.4: 0.2512, 0.5: 0.3309, 0.6: 0.4045, 0.7: 0.4662, 0.8: 0.5024},
    "900 mm": {0.0: 0.0, 0.1: 0.0386, 0.2: 0.1043, 0.3: 0.1847, 0.4: 0.2733, 0.5: 0.3625, 0.6: 0.4511, 0.7: 0.5315, 0.8: 0.5972, 0.9: 0.6358},
    "1000 mm": {0.0: 0.0, 0.1: 0.041, 0.2: 0.111, 0.3: 0.198, 0.4: 0.293, 0.5: 0.392, 0.6: 0.493, 0.7: 0.587, 0.8: 0.674, 0.9: 0.744, 1.0: 0.785},
  };

  @override
  Widget build(BuildContext context) {
    // Saýlanan diametre görä mümkin bolan beýiklikleri alýarys
    final burclar = _tabloData[_selectedDiametr]!;
    
    // Eger saýlanan burç bu diametrde ýok bolsa, iň birinjisini saýlaýarys (howpsuzlyk üçin)
    if (!burclar.containsKey(_selectedBurc)) {
      _selectedBurc = burclar.keys.first;
    }

    double suwMukdary = burclar[_selectedBurc] ?? 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: "Turbanyň diametri", border: OutlineInputBorder()),
            value: _selectedDiametr,
            items: _tabloData.keys.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
            onChanged: (v) => setState(() {
              _selectedDiametr = v!;
              _selectedBurc = _tabloData[v]!.keys.first; // Diametr üýtgände burçy resetleýäris
            }),
          ),
          SizedBox(height: 20),
          DropdownButtonFormField<double>(
            decoration: InputDecoration(labelText: "Suw beýikligi", border: OutlineInputBorder()),
            value: _selectedBurc,
            items: burclar.keys.map((b) => DropdownMenuItem(value: b, child: Text(b.toString()))).toList(),
            onChanged: (v) => setState(() => _selectedBurc = v!),
          ),
          SizedBox(height: 30),
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text("Turbadan geçýän suw:", style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text("${suwMukdary.toStringAsFixed(4)} m³/sek", 
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue.shade900)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
