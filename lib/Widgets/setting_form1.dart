import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes/graficas_provider.dart';

class SettingsForm extends StatefulWidget {
  final int idGraf;
  final String maxVal;
  const SettingsForm({super.key, required this.idGraf, required this.maxVal});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _actualizaMaxVal(BuildContext context) {
    final grafProv =
    Provider.of<GraficasProvider>(context, listen: false);
    final valor =
    double.tryParse(_controller.text); // Obtenemos el texto del campo
    if (valor != null && valor >= 0) {
      if (widget.idGraf == 1) {
        grafProv.setValGraf1(valor);
        grafProv.setMaxGraf1(valor);
      } else {
        grafProv.setValGraf2(valor);
        grafProv.setMaxGraf2(valor);
      }
      _controller.clear(); // Limpia el campo
    } else {
      // Mostrar un mensaje si la entrada no es válida
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, introduce un número válido')),
      );
    }
  }

  void _reseteaActVal(BuildContext context) {
    final grafProv =
    Provider.of<GraficasProvider>(context, listen: false);
    if (widget.idGraf == 1) {
      grafProv.setValGraf1(grafProv.graf1.maxVal);
    } else {
      grafProv.setValGraf2(grafProv.graf2.maxVal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              hintText: 'Max ${widget.maxVal} en el gráfico ${widget.idGraf}',
              hintStyle: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w300),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Ink(
          decoration: BoxDecoration(
            color: Colors.black26,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _reseteaActVal(context),
          ),
        ),
        const SizedBox(width: 5),
        Ink(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () => _actualizaMaxVal(context),
          ),
        ),
      ],
    );
  }
}
