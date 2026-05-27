import 'package:flutter/material.dart';

void main() {
  // Ponto de entrada do app — runApp inicia o Flutter
  runApp(MeuApp());
}

// StatelessWidget = widget que não muda (sem estado)
class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exemplo Tela',
      home: MinhaTela(), // tela inicial do app
    );
  }
}

class MinhaTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold = estrutura base de uma tela no Flutter
    return Scaffold(

      // AppBar = barra superior da tela
      appBar: AppBar(
        title: Text('Minha Primeira Tela'),
        backgroundColor: Colors.blue,
      ),

      // body = conteúdo principal da tela
      body: Center(
        // Column = organiza widgets um abaixo do outro
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // centraliza verticalmente
          children: [
            // Text = exibe um texto
            Text(
              'Olá, Flutter!',
              style: TextStyle(fontSize: 24),
            ),

            SizedBox(height: 20), // espaço entre os widgets

            // ElevatedButton = botão com relevo
            ElevatedButton(
              onPressed: () {
                print('Botão clicado!');
              },
              child: Text('Clique aqui'),
            ),
          ],
        ),
      ),

      // floatingActionButton = botão flutuante no canto inferior direito
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB clicado!');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
