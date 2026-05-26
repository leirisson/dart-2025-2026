import 'package:flutter/material.dart';

void main() => runApp(PerguntaApp());

class PerguntaAppState extends State<PerguntaApp> {
  var perguntaSelecionada = 0;

  void responder() {
    setState(() {
      perguntaSelecionada++;
    });
    print(perguntaSelecionada);
  }

  @override
  Widget build(BuildContext context) {
    final perguntas = [
      "Qual a sua cor favorita ?",
      "Qual o nome do seu cachorro ?",
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("App de perguntas")),
        body: Column(
          children: [
            Text(perguntas[perguntaSelecionada]),
            ElevatedButton(onPressed: responder, child: Text("Resposta 1")),
            ElevatedButton(onPressed: responder, child: Text("Resposta 2")),
          ],
        ),
      ),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  PerguntaAppState createState() {
    return PerguntaAppState();
  }
}
