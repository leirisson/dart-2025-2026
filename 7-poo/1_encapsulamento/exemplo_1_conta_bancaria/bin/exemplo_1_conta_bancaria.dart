import 'dart:io';
import 'package:exemplo_1_conta_bancaria/Conta.dart';

void main(List<String> arguments) {
  double saldo = 0;

  print("Qual o saldo da conta ?: ");
  saldo = double.parse(stdin.readLineSync()!);

  Conta contaExemplo = Conta();

  contaExemplo.depositar(saldo);
  print("Saldo inicial: ${contaExemplo.saldo}");

  print("Qual o deseja depositar ?: ");
  saldo = double.parse(stdin.readLineSync()!);
  contaExemplo.depositar(saldo);
  print(contaExemplo.saldo);

  print("Qual valor deseja sacar ?");
  saldo = double.parse(stdin.readLineSync()!);
  contaExemplo.sacar(saldo);
}
