import 'package:flutter/material.dart';

// Sahypalaryňyzy birikdirýäris
import 'DeryaGidrawlika.dart';
import 'EkinBazasy.dart';
import 'GpsCalculator.dart';
import 'SuwaryshPlan.dart';
import 'Wodosliw.dart';
import 'YapGidrawlika.dart';

void main() {
  runApp(const GidroKalkulyatorApp());
}

class GidroKalkulyatorApp extends StatelessWidget {
  const GidroKalkulyatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  // Sahypa görkeziji logika - her biri öz faýlyna bagly
  Widget _renderContent() {
    switch (activeTab) {
      case 'GPS': return const GpsCalculator();
      case 'Derýa': return const DeryaGidrawlika();
      case 'Yap': return const YapGidrawlika();
      case 'Suwarysh': return const SuwaryshPlan();
      case 'Wodosliw': return const Wodosliw();
      case 'Ekin': return const EkinBazasy();
      default: return const GpsCalculator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset('assets/icon.png', width: 100, height: 100),
                  const Text("Gidrokalkulyator", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            
            // Düzüji maglumaty
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text("Düzüji: Meňli Asyrowa"),
            ),

            // Tab Bar - Sahypa mazmuny
            Expanded(
              child: _renderContent(),
            ),

            // Tab Buttons
            Container(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                children: [
                  _tabButton('GPS'),
                  _tabButton('Derýa'),
                  _tabButton('Yap'),
                  _tabButton('Suwarysh'),
                  _tabButton('Wodosliw'),
                  _tabButton('Ekin'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String title) {
    bool isActive = activeTab == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          activeTab = title;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(title, style: TextStyle(color: isActive ? Colors.white : Colors.black)),
      ),
    );
  }
}
