// ignore_for_file: illegal_character, prefer_const_constructors, prefer_const_literals_to_create_immutables
// lib/gps_calculator.dart
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

  // Nokat goşmak logikasy
  Future<void> addPoint() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("GPS hyzmaty öçüriklidir!")));
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
      setState(() => points.add(position));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Nokat goşuldy: ${position.accuracy.toStringAsFixed(1)}m")));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("GPS signal tapylmady!")));
    }
  }

  // Meýdan hasaplamak (Gauss formulasy - kämil görnüş)
  void calculatePreciseArea() {
    if (points.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Azyndan 3 nokat gerek!")));
      return;
    }

    double area = 0;
    for (int i = 0; i < points.length; i++) {
      var p1 = points[i];
      var p2 = points[(i + 1) % points.length];
      area += (p2.longitude * pi / 180 - p1.longitude * pi / 180) *
          (2 + sin(p1.latitude * pi / 180) + sin(p2.latitude * pi / 180));
    }

    area = (area * 6378137 * 6378137 / 2.0).abs();
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Ölçeýşiň netijesi"),
        content: Text("Meýdan:\n\n${(area / 10000).toStringAsFixed(4)} gektar\n${(area / 100).toStringAsFixed(2)} sotuk\n(${area.toStringAsFixed(0)} m²)"),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS Meýdan Hasaplaýjy")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ElevatedButton(onPressed: addPoint, child: Text("Nokat goş")),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: calculatePreciseArea, 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white), 
              child: Text("Takyk hasapla")
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => setState(() => points.clear()), 
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white), 
              child: Text("Arassala")
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: points.length,
                itemBuilder: (ctx, i) => ListTile(title: Text("Nokat ${i + 1}: ${points[i].latitude.toStringAsFixed(5)}, ${points[i].longitude.toStringAsFixed(5)}")),
              ),
            ),
            Text("Jemi goşulan nokat: ${points.length}", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
