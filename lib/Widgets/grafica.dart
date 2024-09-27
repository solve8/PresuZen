import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Classes/graficas_provider.dart';

class Grafica extends StatefulWidget {
  final double altura, anchura, max, valor;
  final Color colorA, colorB; // Gradient colors
  final int idGrafica;
  final String icon;

  const Grafica(
      {super.key,
      required this.altura,
      required this.anchura,
      required this.max,
      required this.valor,
      required this.colorA,
      required this.colorB,
      required this.icon,
      required this.idGrafica});

  @override
  State<Grafica> createState() => _GraficaState();
}

class _GraficaState extends State<Grafica> {
  final TextEditingController _popupController = TextEditingController();

  @override
  void dispose() {
    _popupController.dispose();
    super.dispose();
  }

  void _mostrarPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Inntroduce el gasto'),
              const SizedBox(height: 10),
              TextField(
                controller: _popupController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Cantidad',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text(
                  'Actualizar',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
                onPressed: () {
                  _actualizarGrafica(context);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _actualizarGrafica(BuildContext context) {
    final grafProv = Provider.of<GraficasProvider>(context, listen: false);
    final valor = double.tryParse(_popupController.text); // Obtenemos el texto del campo

    if (valor == null ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, introduce un número válido.')),
      );
    } else {
      double varAct;
      if (widget.idGrafica == 1) varAct = grafProv.graf1.actVal;
      else varAct = grafProv.graf2.actVal;

      varAct -= valor;
      varAct = double.parse(varAct.toStringAsFixed(2));

      if (varAct < 0) { // Comprobar resultado
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El resultado no puede ser negativo.')),
        );
      } else {  // Setear resultado
        if (widget.idGrafica == 1) grafProv.setValGraf1(varAct);
        else grafProv.setValGraf2(varAct);
        _popupController.clear(); // Limpia el campo
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _mostrarPopup,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: widget.altura,
                width: widget.anchura,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Container(
                height: widget.altura * (widget.valor / widget.max),
                width: widget.anchura,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      widget.colorA,
                      widget.colorB,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0, 0),
                      blurRadius: 20,
                      spreadRadius: -10,
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "${widget.valor} €",
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image(
            image: AssetImage(widget.icon),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
