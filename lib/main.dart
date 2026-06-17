// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

// Esasy modul we hyzmatlaryň import edilmegi
import 'derya_giwrawlika.dart';
import 'ekin_bazasy.dart';
import 'gps_calculator.dart';
import 'suwarysh_plan.dart';
import 'wodosliw.dart';
import 'turba_geciriji.dart';
import 'data/ekin_repository.dart'; // Repository-ni baglamak üçin

void main() {
  runApp(const GidroKalkulyatorApp());
}

class GidroKalkulyatorApp extends StatelessWidget {
  const GidroKalkulyatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GidroKalkulyator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String activeTab = 'GPS';

  final Map<String, IconData> _tabIcons = {
    'GPS': Icons.location_on,
    'Derýa': Icons.water,
    'Suwarysh': Icons.agriculture,
    'Wodosliw': Icons.drain,
    'Ekin': Icons.grass,
    'Turba': Icons.settings_input_composite,
  };

  Widget _renderContent() {
    switch (activeTab) {
      case 'GPS': return GpsCalculator();
      case 'Derýa': return DeryaGiwrawlika();
      case 'Suwarysh': return SuwaryshPlan();
      case 'Wodosliw': return Wodosliw();
      case 'Ekin': return EkinBazasy(); // EkinRepository şu ýerde ulanylýar
      case 'Turba': return TurbaGeciriji();
      default: return GpsCalculator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        title: Text("GidroKalkulyator", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue[800],
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/icon.png'),
                ),
                SizedBox(height: 10),
                Text("Düzüji: Meňli Aşyrowa", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _renderContent(),
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: _tabIcons.keys.map((title) => _tabButton(title)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String title) {
    bool isActive = activeTab == title;
    return InkWell(
      onTap: () => setState(() => activeTab = title),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue[800] : Colors.white,
          border: Border.all(color: Colors.blue[800]!),
          borderRadius: BorderRadius.circular(15),
          boxShadow: isActive ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 8, offset: Offset(0, 4))] : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_tabIcons[title], color: isActive ? Colors.white : Colors.blue[800], size: 18),
            SizedBox(width: 5),
            Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.blue[800], fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
