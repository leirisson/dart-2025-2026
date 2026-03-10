import 'package:exemplo_1_animal/Animal.dart';
import 'package:exemplo_1_animal/Cachorro.dart';
import 'dart:io';
import 'package:exemplo_1_animal/Gato.dart';

void main(List<String> arguments) {
  List<Animal> animais = <Animal>[];
  Gato gato;
  Cachorro cachorro;
  String nome;
  String raca;
  String op;
  do {
    print("CADASTRO DE ANIMAIS");
    print("1 - Gato");
    print("2 - Cachorro");
    print("3 - Listar");
    print("0 - Sair");
    op = stdin.readLineSync()!;

    switch (op) {
      case '1':
        print("CADASTRO DE ANIMAIS");
        print("Qual o nome do pet: ");
        nome = stdin.readLineSync()!;
        print("Qual a reça do pet");
        raca = stdin.readLineSync()!;
        gato = Gato(nome, raca);
        animais.add(gato);
        print("Pet cadastro com sucesso ✅");
      case '2':
        print("CADASTRO DE ANIMAIS");
        print("Qual o nome do pet: ");
        nome = stdin.readLineSync()!;
        print("Qual a reça do pet");
        raca = stdin.readLineSync()!;
        cachorro = Cachorro(nome, raca);
        animais.add(cachorro);
        print("Pet cadastro com sucesso ✅");
      case '3':
        print("# ANIMAIS CADASTRADOS #");
        if (animais.length == 0) {
          print("Sem animais cadastrados.");
        } else {
          for (Animal pet in animais) {
            pet.imprimirInfo();
          }
        }
    }
  } while (op != "0");
}
