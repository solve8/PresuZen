import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes/graficas_provider.dart';
import '../Widgets/grafica.dart';
import 'settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: Consumer<GraficasProvider>(
        builder: (context, graficasProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Grafica(
                    altura: 400,
                    anchura: 80,
                    max: graficasProvider.graf1.maxVal,
                    valor: graficasProvider.graf1.actVal,
                    colorA: const Color(0xFF7BFF98),
                    colorB: const Color(0xFF1FBA00),
                    idGrafica: 1,
                    icon: graficasProvider.graf1.icon,
                  ),
                  Grafica(
                    altura: 400,
                    anchura: 80,
                    max: graficasProvider.graf2.maxVal,
                    valor: graficasProvider.graf2.actVal,
                    colorA: const Color(0xFFFFD17A),
                    colorB: const Color(0xFFBA6300),
                    idGrafica: 2,
                    icon: graficasProvider.graf2.icon,
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          );
        },
      ),
    );
  }
}