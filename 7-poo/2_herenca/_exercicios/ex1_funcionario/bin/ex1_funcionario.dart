import 'dart:io';
import 'package:ex1_funcionario/Desenvolvedor.dart';
import 'package:ex1_funcionario/Estagiario.dart';
import 'package:ex1_funcionario/Funcionario.dart';
import 'package:ex1_funcionario/Gerente.dart';

void main() {
  List<Funcionario> funcionarios = <Funcionario>[];
  String nome;
  double salario;
  double bonus;
  int op;

  do {
    print("SISTEMA DE GERENCIAMENTO DOS FUNCIONARIOS");
    print(" 1️⃣  - Cadastrar um novo gerente.");
    print(" 2️⃣  - Cadastrar um novo desenvolvedor");
    print(" 3️⃣  - cadastrar um novo estagiario");
    print(" 4️⃣  - Listar todos os funcionarios");
    print(" 5️⃣  - sair do sistema ➡️  🔴");
    op = int.parse(stdin.readLineSync()!);

    switch (op) {
      case 1:
        print("TELA DE CADASTRO DE GERNTES");
        print("nome: ");
        nome = stdin.readLineSync()!;
        print("salario: ");
        salario = double.parse(stdin.readLineSync()!);
        print("bonus: ");
        bonus = double.parse(stdin.readLineSync()!);
        Gerente gerente = Gerente(nome, salario, bonus);
        gerente.calcularSalario();
        funcionarios.add(gerente);
        print("funcionario adicionado com sucesso.🎉✅");
      case 2:
        print("TELA DE CADASTRO DE DESENVOLVEDORES");
        print("nome: ");
        nome = stdin.readLineSync()!;
        print("salario: ");
        salario = double.parse(stdin.readLineSync()!);
        print("bonus: ");
        bonus = double.parse(stdin.readLineSync()!);
        Desenvolvedor dev = Desenvolvedor(nome, salario, bonus);
        dev.calcularSalario();
        funcionarios.add(dev);
        print("funcionario adicionado com sucesso.🎉✅");
      case 3:
        print("TELA DE CADASTRO DE ESTAGIARIOS");
        print("nome: ");
        nome = stdin.readLineSync()!;
        print("salario: ");
        salario = double.parse(stdin.readLineSync()!);
        Estagiario est = Estagiario(nome, salario);
        funcionarios.add(est);
        print("funcionario adicionado com sucesso.🎉✅");
      case 4:
        for (Funcionario fun in funcionarios) {
          fun.imprimirInfo();
        }
    }
  } while (op != 5);
}
