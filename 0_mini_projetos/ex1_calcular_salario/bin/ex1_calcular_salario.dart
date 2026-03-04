import 'dart:io';
// 1️⃣ Cálculo de Salário Mensal
// Um funcionário recebe R$ 25 por hora e trabalhou 160 horas no mês.
// 📌 Faça um programa que:
// Receba o valor da hora
// Receba a quantidade de horas trabalhadas
// Calcule o salário mensal
// Mostre o resultado

void main() {
  double valorHhora = 0;
  double qtdHorasTrabalhadas = 0;
  double salarioBruto = 0;
  double salarioLiquido = 0;
  double descontoInss = 0;
  double descontoProcentagem = 0.10;

  print("Qual a quantidade de horas trabalhadas: ");
  qtdHorasTrabalhadas = double.parse(stdin.readLineSync()!);
  print("qual o valor da hora de trabalho: ");
  valorHhora = double.parse(stdin.readLineSync()!);

  salarioBruto = (qtdHorasTrabalhadas * valorHhora);
  descontoInss = (salarioBruto * descontoProcentagem);
  salarioLiquido = (salarioBruto - descontoInss);

  print("Salario mensal: $salarioBruto");
  print("INSS: $descontoInss");
  print("Salário Líquido: $salarioLiquido");
}
