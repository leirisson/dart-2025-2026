import 'dart:io';

// 🟢 Exercício 6 — Cálculo de Ticket Médio (E-commerce)
// Uma loja online quer medir seu desempenho.
// 📌 O sistema deve receber:
// Total faturado no dia
// Quantidade de pedidos

/**
 * EXPLICAÇÃO
 * LER E ENTENDER O PROBLEMA
 * IDENTIFICAR AS VARIAVAIS
 * IDENTIFICAR AS REGRAS DE NEGOCIO
 * DECLARAR AS VARIAVEIS
 * CAPTURAR DADOS DO USUARIO
 * REALIZAR OS CALSULOS DE TICKE MEDIO E PROJEÇÃO
 * EXIBIR PARA O USUARIO
*/

void main() {
  double ticketMedio = 0;
  double projecaoFutura = 0;
  int projecaoDepedidos = 0;
  int pedidos = 0;
  double faturamento = 0;

  print("Quantos pedidos foram feitos ?");
  pedidos = int.parse(stdin.readLineSync()!);

  print("Qual o faturamento diario do dia  ?: ");
  faturamento = double.parse(stdin.readLineSync()!);

  print("Qual a projeção de futuros pedidos ?: ");
  projecaoDepedidos = int.parse(stdin.readLineSync()!);

  ticketMedio = faturamento / pedidos;
  projecaoFutura = ticketMedio * projecaoDepedidos;

  print("Ticket médio: ${ticketMedio.toStringAsFixed(0)}");
  print("Projeção para $projecaoDepedidos pedidos: ${projecaoFutura.toStringAsFixed(0)}");
}
