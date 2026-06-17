// lib/services/calculator_service.dart
class CalculatorService {
  // Ulanyjynyň 15% suw ýitgisi baradaky görkezmesini hasaba alyň
  static double calculateTotalWithLoss(double normaM3) {
    double lossMargin = 1.15; 
    return normaM3 * lossMargin;
  }
}
