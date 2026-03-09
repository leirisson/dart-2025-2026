import 'dart:io';
import 'package:exemplo_5_sistema_funcionarios/Funcionario.dart';

void main() {
  Funcionario f1;
  String nome;
  double salario;

  print("CADASTRO DE FUNCIONARIO");
  print("Nome: ");
  nome = stdin.readLineSync()!;
  print("salario: ");
  salario = double.parse(stdin.readLineSync()!);
  f1 = Funcionario(nome, salario);

  print("Cadastro realizado...");
  print("Salario: ${f1.consultarSalario()}");

  print("almentando o salario em %");
  double porcentagem;
  print("Quantos porcentos deseja almentar o salario: ");
  porcentagem = double.parse(stdin.readLineSync()!);
  f1.aumentarSalario(porcentagem);

  print("consultando salario novamente: ");
  print(f1.consultarSalario());
}
