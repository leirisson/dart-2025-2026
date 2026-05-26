import 'package:flutter/material.dart';

void main() => runApp(new PerguntaApp());

class PerguntaApp extends StatelessWidget {
  final List<String> perguntas = [
    'Qual é a sua cor favorita',
    'Qual é a sua idade ?',
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Perguntas")),
        body: Column(
          children: <Widget>[
            Text(perguntas.elementAt(0)),
            ElevatedButton(onPressed: null, child: Text("Resposta 1")),
            ElevatedButton(onPressed: null, child: Text("Resposta 2")),
            ElevatedButton(onPressed: null, child: Text("Resposta 3")),
          ],
        ),
      ),
    );
  }
}
