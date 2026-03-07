import 'dart:io';

void main() {
  Map<String, int> carrinho = {};

  print("qual produto deseja cadastrar: ");
  String? nomeProduto = stdin.readLineSync();

  print("qual a quantidade desse produto ?");
  int? quantidade = int.parse(stdin.readLineSync()!);

  carrinho[nomeProduto!] = quantidade; 

  print("produtos: ");
  print(carrinho);
}
