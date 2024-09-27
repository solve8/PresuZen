import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes/graficas_provider.dart';
import '../Widgets/setting_form.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
      ),
      body: Consumer<GraficasProvider>(
          builder: (context, grafProv, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SettingsForm(
                      idGraf: 1,
                      maxVal: grafProv.graf1.maxVal.toString()),
                  const SizedBox(height: 18),
                  SettingsForm(
                      idGraf: 2,
                      maxVal: grafProv.graf2.maxVal.toString()),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text("Made by solve 👨🏻‍💻"),
            )
          ],
        );
      }),
    );
  }
}