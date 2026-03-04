import 'dart:io';

// 🟢 Exercício 2 — Controle de Vendas (Loja)
// Você precisa criar um sistema simples para calcular a comissão de um vendedor.
// 📌 Regras:
// O vendedor informa:
// Valor total vendido no mês
// A empresa paga:
// 5% de comissão sobre as vendas
// O vendedor tem salário fixo de R$ 1.500
// 🎯 O programa deve calcular:
// Comissão
// Salário final (fixo + comissão)

void main() {
  double total_venda_mes = 0;
  double salarioFixo = 1500;
  double taxaComissao = 0.05;
  double comissao = 0;
  double salarioComissinaldo = 0;

  print("Qual foi é o valor total de vendas do mês ?");
  total_venda_mes = double.parse(stdin.readLineSync()!);
  comissao = (total_venda_mes * taxaComissao);
  salarioComissinaldo = (salarioFixo + comissao);

  print("Informações do mês");
  print("Comissão: ${comissao.toStringAsFixed(2)}");
  print("Salário: ${salarioComissinaldo.toStringAsFixed(2)}");
}
