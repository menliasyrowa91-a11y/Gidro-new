import 'package:flutter/material.dart';
import 'EkinBazasy.dart'; // EkinBazasy maglumatlary üçin

class SuwaryshPlan extends StatefulWidget {
  const SuwaryshPlan({super.key});

  @override
  State<SuwaryshPlan> createState() => _SuwaryshPlanState();
}

class _SuwaryshPlanState extends State<SuwaryshPlan> {
  final TextEditingController _meydanController = TextEditingController(text: '10');
  final TextEditingController _qController = TextEditingController(text: '0.15');
  
  // Dropdown ýerine sizdäki ýaly düwmeleri ulanýarys
  Ekin _selectedEkin = Ekin(ady: "Gowaça", norma: 2700, kpd: 0.85);

  final List<Ekin> ekinListesi = [
    Ekin(ady: "Gowaça", norma: 2700, kpd: 0.85),
    Ekin(ady: "Bugdaý", norma: 1400, kpd: 0.80),
    Ekin(ady: "Mekgejöwen", norma: 800, kpd: 0.82),
    Ekin(ady: "Arpa", norma: 1200, kpd: 0.80),
    Ekin(ady: "Hyýar", norma: 900, kpd: 0.85),
  ];

  void _calculatePlan() {
    final valM = double.tryParse(_meydanController.text);
    final valQ = double.tryParse(_qController.text);

    if (valM == null || valQ == null || valQ == 0) {
      showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text("Ýalňyşlyk"), content: const Text("Sanlary dogry giriziň!"), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))]));
      return;
    }

    // Hasaplaýyş
    final t = (valM * _selectedEkin.norma) / (valQ * 3600 * _selectedEkin.kpd);
    
    showDialog(
      context: context, 
      builder: (ctx) => AlertDialog(
        title: const Text("Netije"),
        content: Text("${_selectedEkin.ady} üçin suwaryş wagty: ${t.toStringAsFixed(1)} sagat"),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Suwaryş Meýilnamasy", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            const Text("Ekin görnüşini saýlaň:"),
            Wrap(
              alignment: WrapAlignment.center,
              children: ekinListesi.map((ekin) {
                bool isSelected = _selectedEkin.ady == ekin.ady;
                return GestureDetector(
                  onTap: () => setState(() => _selectedEkin = ekin),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: isSelected ? const Color(0xFF059669) : Colors.grey[200], borderRadius: BorderRadius.circular(5)),
                    child: Text(ekin.ady, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(controller: _meydanController, decoration: const InputDecoration(labelText: "Meýdan (ga)"), keyboardType: TextInputType.number),
            TextField(controller: _qController, decoration: const InputDecoration(labelText: "Suw akymy (m³/s)"), keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculatePlan,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF059669), foregroundColor: Colors.white, padding: const EdgeInsets.all(15)),
              child: const Text("HASAPLA"),
            ),
          ],
        ),
      ),
    );
  }
}
