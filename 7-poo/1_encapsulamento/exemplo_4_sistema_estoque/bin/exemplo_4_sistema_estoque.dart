import 'dart:io';
import 'package:exemplo_4_sistema_estoque/Produto.dart';

void main(List<String> arguments) {
  List<Produto> produtos = <Produto>[];
  String op;
  do {
    print("Escolha um opção:");
    print("1 - Cadastrar produto");
    print("2 - Listar Produtos");
    print("3 - vender produto");
    print("0 - Sair");
    op = stdin.readLineSync()!;

    switch (op) {
      case '1':
        String nome;
        int quantidade;
        Produto p;
        print("Qual o nome do produto ?");
        nome = stdin.readLineSync()!;
        print("Qual a quantidade do produto: ");
        quantidade = int.parse(stdin.readLineSync()!);
        p = Produto(nome, quantidade);
        produtos.add(p);
      case '2':
        print("PRODUTOS CADASTRADOS");
        for (Produto p in produtos) {
          print('nome: ${p.nome} | estoque: ${p.consultarEstoque()}');
        }
      case '3':
        print("VENDA DE PRODUTOS");
        String nome;
        int quantidade;
        Produto p;
        print("Qual o nome do produto ?");
        nome = stdin.readLineSync()!;
        print("Qual a quantidade do produto deseja vender ? ");
        quantidade = int.parse(stdin.readLineSync()!);
        p = Produto(nome, quantidade);
        for(Produto produto in produtos){
          if(produto.nome == p.nome){
            p.vender(quantidade);
          }
        }

    }
  } while (op != '0');
}
