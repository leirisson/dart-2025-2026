import 'package:exemplo_1_animal/Animal.dart';

class Cachorro extends Animal {
  Cachorro(super.nome, super.raca);

  @override
  void imprimirInfo() {
    print("Nome: $nome | Raça: $raca");
  }
}
