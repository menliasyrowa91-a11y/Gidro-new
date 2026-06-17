// lib/suwarysh_plan.dart
import 'package:flutter/material.dart';
import 'data/ekin_repository.dart'; // Repository-ni çagyryň
import 'services/calculator_service.dart'; // Kalkulýator hyzmatyny çagyryň

class SuwaryshPlan extends StatefulWidget {
  const SuwaryshPlan({super.key});

  @override
  State<SuwaryshPlan> createState() => _SuwaryshPlanState();
}

class _SuwaryshPlanState extends State<SuwaryshPlan> {
  // Repository-den ähli ekinleri alýarys
  final List<Ekin> ekinBazasy = EkinRepository.allEkinler;
  
  late Ekin _selectedEkin;
  late Tapgyr _selectedTapgyr;

  final TextEditingController _akymController = TextEditingController(text: '9.35');
  final TextEditingController _gaController = TextEditingController(text: '1');
  final double _ptk = 0.85; // Suw ýitgisi koeffisiýenti

  @override
  void initState() {
    super.initState();
    _selectedEkin = ekinBazasy[0];
    _selectedTapgyr = _selectedEkin.tapgyrlar[0];
  }

  void _hesapla() {
    double qLs = double.tryParse(_akymController.text) ?? 0;
    double ga = double.tryParse(_gaController.text) ?? 0;
    
    // Suwaryş hasaplamasy
    double qM3s = qLs / 1000;
    // CalculatorService-i ulanyp, 15% ýitgini hasaba alýarys
    double gun = (qM3s * _ptk * 86400) / _selectedTapgyr.normaM3;
    double nettoM3 = ga * _selectedTapgyr.normaM3;
    double jemiBaha = ga * _selectedTapgyr.baha;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_selectedEkin.ady),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Tapgyr: ${_selectedTapgyr.ady}"),
            Text("Möhleti: ${_selectedTapgyr.mohlet}"),
            Text("Dowamlylygy: ${gun.toStringAsFixed(2)} gün"),
            Divider(),
            Text("Netto: ${nettoM3.toStringAsFixed(0)} m³"),
            Text("Baha: ${jemiBaha.toStringAsFixed(2)} manat"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DropdownButtonFormField<Ekin>(
            value: _selectedEkin,
            items: ekinBazasy.map((e) => DropdownMenuItem(value: e, child: Text(e.ady))).toList(),
            onChanged: (v) => setState(() {
              _selectedEkin = v!;
              _selectedTapgyr = v.tapgyrlar[0];
            }),
            decoration: InputDecoration(labelText: "Ekini saýlaň"),
          ),
          DropdownButtonFormField<Tapgyr>(
            value: _selectedTapgyr,
            items: _selectedEkin.tapgyrlar.map((t) => DropdownMenuItem(value: t, child: Text(t.ady))).toList(),
            onChanged: (v) => setState(() => _selectedTapgyr = v!),
            decoration: InputDecoration(labelText: "Tapgyry saýlaň"),
          ),
          TextField(controller: _akymController, decoration: InputDecoration(labelText: "Akym (l/sek)")),
          TextField(controller: _gaController, decoration: InputDecoration(labelText: "Meýdan (ga)")),
          SizedBox(height: 20),
          ElevatedButton(onPressed: _hesapla, child: Text("HASAPLA")),
        ],
      ),
    );
  }
}
