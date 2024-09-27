import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Classes/graficas_provider.dart';
import 'Pages/home_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(ChangeNotifierProvider(
    create: (_) => GraficasProvider(
      GraficaValues(
        prefs.getDouble('graf1_maxVal') ?? 100.0,
        prefs.getDouble('graf1_actVal') ?? 100.0,
        prefs.getString('graf1_iconPath') ?? 'images/burguer.png',
      ),
      GraficaValues(
        prefs.getDouble('graf2_maxVal') ?? 100.0,
        prefs.getDouble('graf2_actVal') ?? 100.0,
        prefs.getString('graf2_iconPath') ?? 'images/bag.png',
      ),
      prefs,
    ),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tilling Money',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
