import 'package:ex1_funcionario/Funcionario.dart';

class Gerente extends Funcionario {
  double bonus = 0;
  Gerente(super.nome, super.salario, this.bonus);

  @override
  void calcularSalario() {
    salario += salario * (bonus / 100);
  }

  @override
  void imprimirInfo() {
    print("nome: $nome | salario: $salario | bonus: $bonus");
  }
}
