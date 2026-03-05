// // Controle de Estoque (Empresa)
// Agora vamos simular um sistema de almoxarifado.
// Uma empresa compra um produto por um valor unitário e quer calcular:
// Valor total da compra
// Valor com acréscimo de 18% de imposto
// Entrada:
// Valor unitário do produto
// Quantidade comprada
// O programa deve calcular:
// Valor total sem imposto
// Valor do imposto (18%)
// Valor final com imposto

/**
 * EXPLICAÇÃO DO CÓDIGO
 * primeiro declarei as variaveis com para separar as suas responsabilidades
 * depois calculei o total uma vez para que esse código não se repetice 
 * varias vezes
 * depois fiz o calculo do valorImposto, valorTotalSemImposto, valorTotalComImposto
 * por ultimo fiz a exibição de formatada com 2 casas decimais 
 */

import 'dart:io';

void main() {
  double imposto = 0.18;
  double valorImposto = 0;
  int qtdComprada = 0;
  double valorUnitario = 0;
  double valorTotalSemImposto = 0;
  double valorTotalComImposto = 0;
  double totalCompra = 0;

  print("Qual o valor unitario do produto ?");
  valorUnitario = double.parse(stdin.readLineSync()!);
  print("Qual a quantidade comprada ?: ");
  qtdComprada = int.parse(stdin.readLineSync()!);

  totalCompra = qtdComprada * valorUnitario;

  valorImposto = (totalCompra * imposto);
  valorTotalSemImposto = totalCompra;
  valorTotalComImposto = (totalCompra + valorImposto);

  print("Valor total sem imposto: ${valorTotalSemImposto.toStringAsFixed(2)}");
  print("Valor totoal com imposto: ${valorTotalComImposto.toStringAsFixed(2)}");
  print("valor do imposto: ${valorImposto.toStringAsFixed(2)}");
  print("imposto: ${(imposto*100).toStringAsFixed(2)}%");
}
