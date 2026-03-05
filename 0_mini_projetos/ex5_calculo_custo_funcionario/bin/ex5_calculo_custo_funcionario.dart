// 🔥 Exercício 5 — Cálculo de Custo de Funcionário com Benefícios
// Agora vamos simular RH corporativo.
// A empresa paga:
// Salário base
// Vale alimentação (R$ 600 fixo)
// Vale transporte (R$ 300 fixo)
// 📌 O sistema deve calcular:
// Custo total do funcionário para empresa
// Percentual que os benefícios representam sobre o salário base

import 'dart:io';

void main() {
  double salarioBase = 0; //3000;
  double valeAlimentacao = 600;
  double valeTransporte = 300;
  double porcentagem = 0;
  double salarioTotal = 0;
  double beneficios = 0;

  print("qual o salario do funcionario ?:");
  salarioBase = double.parse(stdin.readLineSync()!);


  salarioTotal = salarioBase + valeTransporte + valeAlimentacao;
  beneficios = valeTransporte + valeAlimentacao;

  porcentagem = (beneficios / salarioBase) * 100;

  print("Custo total: $salarioTotal");
  print("Percentual benefícios: ${porcentagem.toStringAsFixed(2)}%");
}

/**
 * EXPLICAÇÃO DO CODIGO:
 * PRIMEIRO DECLAREI AS VARIAVEIS PARA ORGANIZAR O CODIGO
 * CAPTUREI A ENTRADA DO SALARIO BASE
 * CALCULEI O SALARIO TOTAL SOMANDO O SALARIO BASE MAIS OS BENEFICIOS
 * CALCULEI O PERCENTUAL DO BENEFIOS CORRESPONDENTE DO SALARIO
 * E POR UTIMO EXIBIÇÃO DE FORMATADA PARA O USUARIO
 */