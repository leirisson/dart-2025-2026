import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

void main() => runApp(PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var perguntaSelecionada = 0;

  void _responder() {
    setState(() {
      perguntaSelecionada++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> _perguntas = [
      {
        'texto': "Qual a sua cor favorita ?",
        'resposta': ['azul', 'verde', 'amarelo'],
      },
      {
        'texto': "Qual o nome do seu animal ?",
        'resposta': ['coelho', 'elefante', 'girafa'],
      },
      {
        'texto': "Qual o seu esporte favorito ?",
        'resposta': ['futebol', 'basquete', 'natação'],
      },
      {
        'texto': "Qual a sua fruta favorita ?",
        'resposta': ['manga', 'banana', 'morango'],
      },
      {
        'texto': "Qual o seu meio de transporte favorito ?",
        'resposta': ['carro', 'moto', 'bicicleta'],
      },
      {
        'texto': "Qual a sua estação do ano favorita ?",
        'resposta': ['verão', 'inverno', 'primavera'],
      },
      {
        'texto': "Qual o seu hobby favorito ?",
        'resposta': ['leitura', 'jogos', 'culinária'],
      },
    ];

    // Constrói dinamicamente os botões de resposta da pergunta atual
    // List<Widget> respostas = [];
    // for(String textoResp in _perguntas[perguntaSelecionada]['resposta'] as List){
    //   respostas.add(Resposta(textoResp, _responder));
    // }

    List<String> respostas = _perguntas[perguntaSelecionada]['resposta'] as List<String>;


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("App de perguntas")),
        body: Column(
          children: [
            Questao(_perguntas[perguntaSelecionada]['texto'] as String),
            ...respostas.map((texto) => Resposta(texto, _responder)),
          ],
        ),
      ),
    );
  }
}

class PerguntaApp extends StatefulWidget {
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}
