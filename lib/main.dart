import 'package:flutter/material.dart';

void main() {
  runApp(CalcImc());
}

class CalcImc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calcula IMC',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
       debugShowCheckedModeBanner: false, 
      home: TelaCalculadoraIMC(),
    );
  }
}

class TelaCalculadoraIMC extends StatefulWidget {
  @override
  _TelaCalculadoraIMCState createState() => _TelaCalculadoraIMCState();
}

class _TelaCalculadoraIMCState extends State<TelaCalculadoraIMC> {
  TextEditingController AlturaController = TextEditingController();
  TextEditingController PesoController = TextEditingController();
  double result = 0.0;
  String classification = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: AlturaController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: 'Altura (m)'),
            ),
            TextField(
              controller: PesoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Peso (kg)'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                calcula();
              },
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Resultado: ${result.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Classificação: $classification',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }

  void calcula() {
    String AlturaText = AlturaController.text.replaceAll(',', '.'); //Substituir vírgula por ponto
    double Altura = double.tryParse(AlturaText) ?? 0.0;
    double Peso = double.tryParse(PesoController.text) ?? 0.0;

    if (Altura > 0 && Peso > 0) {
      double imc = Peso / (Altura * Altura);
      setState(() {
        result = imc;
        classification = tipoimc(imc);
      });
    } else {
      setState(() {
        result = 0.0;
        classification = '';
      });
    }
  }

  String tipoimc(double imc) {
    if (imc <= 18.5) {
      return 'Abaixo do peso ideal';
    } else if (imc > 18.5 && imc <= 25) {
      return 'Peso ideal';
    } else if (imc > 25 && imc < 30) {
      return 'Acima do peso';
    } else {
      return 'Obeso';
    }
  }
}
