import 'package:ex1_funcionario/Funcionario.dart';

class Estagiario extends Funcionario {
  Estagiario(super.nome, super.salario);

  @override
  void imprimirInfo() {
    print("nome: $nome | salario: $salario");
  }
}
