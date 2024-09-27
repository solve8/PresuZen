import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraficaValues extends ChangeNotifier {
  double _maxVal;
  double _actVal;
  String _icon;

  GraficaValues(this._maxVal, this._actVal, this._icon);

  // Getters
  double get maxVal => _maxVal;
  double get actVal => _actVal;
  String get icon => _icon;

  // Setters
  void setMaxVal(double newMax) {
    _maxVal = newMax;
  }

  void setCurVal(double nuevoValorActual) {
    _actVal = nuevoValorActual;
  }

  void setIcon(String iconPath) {
    _icon = iconPath;
  }
}

// Clase que maneja el estado de las dos gráficas.
class GraficasProvider extends ChangeNotifier {
  final GraficaValues graf1;
  final GraficaValues graf2;
  final SharedPreferences prefs;

  GraficasProvider(this.graf1, this.graf2, this.prefs);

  Future<void> setMaxGraf1(double newMax) async {
    graf1.setMaxVal(newMax);
    notifyListeners(); // Notifica primero para actualizar la UI de inmediato
    await prefs.setDouble('graf1_maxVal', newMax); // Guarda en segundo plano
  }

  Future<void> setValGraf1(double newVal) async {
    graf1.setCurVal(newVal);
    notifyListeners(); // Actualiza la UI de inmediato
    await prefs.setDouble('graf1_actVal', newVal);
  }

  Future<void> setMaxGraf2(double newMax) async {
    graf2.setMaxVal(newMax);
    notifyListeners();
    await prefs.setDouble('graf2_maxVal', newMax);
  }

  Future<void> setValGraf2(double newVal) async {
    graf2.setCurVal(newVal);
    notifyListeners();
    await prefs.setDouble('graf2_actVal', newVal);
  }

  Future<void> setIconGraf1(String iconPath) async {
    graf1.setIcon(iconPath);
    notifyListeners();
    await prefs.setString('graf1_iconPath', iconPath);
  }

  Future<void> setIconGraf2(String iconPath) async {
    graf2.setIcon(iconPath);
    notifyListeners();
    await prefs.setString('graf2_iconPath', iconPath);
  }
}
