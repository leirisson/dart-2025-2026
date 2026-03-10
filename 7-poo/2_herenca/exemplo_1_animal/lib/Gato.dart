import 'package:exemplo_1_animal/Animal.dart';

class Gato extends Animal {
  Gato(super.nome, super.raca);

  @override
  void imprimirInfo() {
    print("Nome: $nome | Raça: $raca");
  }
}
