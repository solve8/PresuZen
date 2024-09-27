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
    final grafProv = Provider.of<GraficasProvider>(context, listen: false);
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
    final grafProv = Provider.of<GraficasProvider>(context, listen: false);
    if (widget.idGraf == 1) {
      grafProv.setValGraf1(grafProv.graf1.maxVal);
    } else {
      grafProv.setValGraf2(grafProv.graf2.maxVal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            MyDropdownButton(idGraf: widget.idGraf),
            const SizedBox(width: 10),
            Text(
              "Gráfico ${widget.idGraf}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            )
          ],
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey, width: 1), // Color del borde cuando está enfocado
                  ),
                  hintText:
                      'Max actual ${widget.maxVal}',
                  hintStyle: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w300, ),
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
        ),
      ],
    );
  }
}

const List<String> list = <String>[
  'images/bag.png',
  'images/burguer.png',
  'images/euro.png',
  'images/locker.png',
  'images/mobile.png',
  'images/wallet.png'
];

class MyDropdownButton extends StatefulWidget {
  final int idGraf;
  const MyDropdownButton({super.key, required this.idGraf});

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String dropdownValue = '';
  late GraficasProvider grafProv;

  @override
  void initState() {
    super.initState();
    grafProv = Provider.of<GraficasProvider>(context, listen: false);
    if (widget.idGraf == 1) {
      dropdownValue = grafProv.graf1.icon;
    } else {
      dropdownValue = grafProv.graf2.icon;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<String>(
        padding: const EdgeInsets.only(left: 5.0),
        value: dropdownValue,
        icon: const Icon(Icons.chevron_left),
        elevation: 16,
        underline: const SizedBox(),
        borderRadius: BorderRadius.circular(10),
        onChanged: (String? value) {
          setState(() {
            dropdownValue = value!;
            if (widget.idGraf == 1) {
              grafProv.setIconGraf1(value);
            } else {
              grafProv.setIconGraf2(value);
            }
          });
        },
        items: list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Center(
              child: Image(
                image: AssetImage(value),
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
            )
          );
        }).toList(),
      ),
    );
  }
}
