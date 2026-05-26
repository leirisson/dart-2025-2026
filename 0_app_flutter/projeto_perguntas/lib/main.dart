import 'package:flutter/material.dart';

void main() => runApp(new PerguntaApp());

class PerguntaApp extends StatelessWidget {

  void responder(){
    print("Pergunta Respondida");
  }


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
            ElevatedButton(onPressed: responder, child: Text("Resposta 1")),
            ElevatedButton(onPressed: responder, child: Text("Resposta 2")),
            ElevatedButton(onPressed: responder, child: Text("Resposta 3")),
          ],
        ),
      ),
    );
  }
}
