// lib/suwarysh_plan.dart
import 'package:flutter/material.dart';
import 'ekin_model.dart'; // Ekin we Tapgyr klasslaryny çagyrmak üçin
import 'data/ekin_repository.dart'; 

class SuwaryshPlan extends StatefulWidget {
  const SuwaryshPlan({super.key});

  @override
  State<SuwaryshPlan> createState() => _SuwaryshPlanState();
}

class _SuwaryshPlanState extends State<SuwaryshPlan> {
  // Repository-den ekinleriň sanawyny alýarys
  final List<Ekin> ekinBazasy = EkinRepository.allEkinler;
  
  late Ekin _selectedEkin;
  late Tapgyr _selectedTapgyr;

  final TextEditingController _akymController = TextEditingController(text: '9.35');
  final TextEditingController _gaController = TextEditingController(text: '1');

  @override
  void initState() {
    super.initState();
    // Ilkinji ekini we onuň ilkinji tapgyryny saýlaýarys
    _selectedEkin = ekinBazasy[0];
    _selectedTapgyr = _selectedEkin.tapgyrlar[0];
  }

  void _hesapla() {
    double qLs = double.tryParse(_akymController.text) ?? 0;
    double ga = double.tryParse(_gaController.text) ?? 0;
    
    // Suwaryş hasaplamasy
    double qM3s = qLs / 1000;
    double gun = (qM3s * 86400) / _selectedTapgyr.normaM3;
    
    double nettoM3 = ga * _selectedTapgyr.normaM3;
    double jemiBaha = ga * _selectedTapgyr.baha;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_selectedEkin.ady),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tapgyr: ${_selectedTapgyr.ady}"),
            Text("Möhleti: ${_selectedTapgyr.mohlet}"),
            Text("Dowamlylygy: ${gun.toStringAsFixed(2)} gün"),
            const Divider(),
            Text("Netto (15% ýitgi goşulan): ${nettoM3.toStringAsFixed(0)} m³"),
            Text("Baha: ${jemiBaha.toStringAsFixed(2)} manat"),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Ýap"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Ekin saýlamak üçin Dropdown
          DropdownButtonFormField<Ekin>(
            value: _selectedEkin,
            items: ekinBazasy.map((e) => DropdownMenuItem(value: e, child: Text(e.ady))).toList(),
            onChanged: (v) => setState(() {
              _selectedEkin = v!;
              _selectedTapgyr = v.tapgyrlar[0]; // Ekin üýtgende tapgyry hem täzele
            }),
            decoration: const InputDecoration(labelText: "Ekini saýlaň"),
          ),
          // Tapgyr saýlamak üçin Dropdown
          DropdownButtonFormField<Tapgyr>(
            value: _selectedTapgyr,
            items: _selectedEkin.tapgyrlar.map((t) => DropdownMenuItem(value: t, child: Text(t.ady))).toList(),
            onChanged: (v) => setState(() => _selectedTapgyr = v!),
            decoration: const InputDecoration(labelText: "Tapgyry saýlaň"),
          ),
          TextField(controller: _akymController, decoration: const InputDecoration(labelText: "Akym (l/sek)")),
          TextField(controller: _gaController, decoration: const InputDecoration(labelText: "Meýdan (ga)")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _hesapla, child: const Text("HASAPLA")),
        ],
      ),
    );
  }
}
