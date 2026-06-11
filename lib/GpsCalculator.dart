import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

class GpsCalculator extends StatefulWidget {
  const GpsCalculator({super.key});

  @override
  State<GpsCalculator> createState() => _GpsCalculatorState();
}

class _GpsCalculatorState extends State<GpsCalculator> {
  List<Position> points = [];

  Future<void> addPoint() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("GPS hyzmaty öçüriklidir!")));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
      );

      setState(() {
        points.add(position);
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Nokat goşuldy: Takyklyk ${position.accuracy.toStringAsFixed(1)}m"),
      ));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("GPS signal tapylmady!")));
    }
  }

  void calculatePreciseArea() {
    if (points.length < 3) {
      showDialog(context: context, builder: (ctx) => AlertDialog(title: const Text("Ýalňyşlyk"), content: const Text("Azyndan 3 nokat goşuň!"), actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))]));
      return;
    }

    const double R = 6378137;
    double area = 0;

    for (int i = 0; i < points.length; i++) {
      Position p1 = points[i];
      Position p2 = points[(i + 1) % points.length];
      area += (p2.longitude * pi / 180 - p1.longitude * pi / 180) * (2 + sin(p1.latitude * pi / 180) + sin(p2.latitude * pi / 180));
    }

    area = (area * R * R / 2.0).abs();
    final ga = (area / 10000).toStringAsFixed(4);
    final sotuk = (area / 100).toStringAsFixed(2);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Ölçeýşiň Netijesi"),
        content: Text("Meýdan:\n\n$ga gektar\n$sotuk sotuk\n(${area.toStringAsFixed(0)} m²)"),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(onPressed: addPoint, child: const Text("Nokat Goş")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: calculatePreciseArea, style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white), child: const Text("Takyk Hasapla")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: () => setState(() => points.clear()), style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white), child: const Text("Arassala")),
            const SizedBox(height: 20),
            Text("Goşulan nokatlar: ${points.length}"),
          ],
        ),
      ),
    );
  }
}
