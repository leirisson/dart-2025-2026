import 'dart:io';
import 'package:ex1_sistema_estacionamento/Estacionamento.dart';

void main() {
  Estacionamento estacionamento;
  int vagas;
  String op;

  print("Quantas vagas tem o estacionamento: ");
  vagas = int.parse(stdin.readLineSync()!);
  estacionamento = Estacionamento(vagas);

  do {
    print("ESCOLHA UMA OPÇÃO: ");
    print("1 - Entrada de carro");
    print("2 - Saida de Carro");
    print("3 - Consultar vags");
    print('0 - Sair');
    op = stdin.readLineSync()!;

    switch (op) {
      case '1':
        print("ENTRADA DE VEICULOS");
        int qtdVeiculos;
        print("quantos veiculos estacionaram ?");
        qtdVeiculos = int.parse(stdin.readLineSync()!);
        estacionamento.entrarCarro(qtdVeiculos);
      case '2':
        print("RETIRADA DE VEICULOS");
        int qtdVeiculos;
        print("quantos veiculos estacionaram ?");
        qtdVeiculos = int.parse(stdin.readLineSync()!);
        estacionamento.sairCarro(qtdVeiculos);
      case '3':
        print("VAGAS DISPONIVEIS");
        print(estacionamento.consultarVagas());
    }
  } while (op != '0');
}
