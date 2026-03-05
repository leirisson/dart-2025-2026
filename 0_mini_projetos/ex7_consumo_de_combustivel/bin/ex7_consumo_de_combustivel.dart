import 'dart:io';
// Exercício 7 — Cálculo de Consumo de Combustível (Empresa de Transporte)
// Uma empresa quer calcular o desempenho de seus veículos.
// 📌 O sistema deve receber:
// Distância percorrida (km)
// Combustível gasto (litros)
// Preço do litro do combustível

void main() {
  double distanciaPercorrida = 0;
  double combustivelGasto = 0;
  double precoCombustivel = 0;
  double consumoMedioDoveiculo = 0;
  double custoTotalDaViagem = 0;
  double custoporKmRodado = 0;

  print("Qual a distância percorrida (km): ");
  distanciaPercorrida = double.parse(stdin.readLineSync()!);
  print("Qual a quantidade de combustível gasto (litros): ");
  combustivelGasto = double.parse(stdin.readLineSync()!);
  print("Qual o preço do litro do combustível: ");
  precoCombustivel = double.parse(stdin.readLineSync()!);

  consumoMedioDoveiculo = distanciaPercorrida / combustivelGasto;
  custoTotalDaViagem = combustivelGasto * precoCombustivel;
  custoporKmRodado = custoTotalDaViagem / distanciaPercorrida;


  print("Consumo médio: $consumoMedioDoveiculo km/L");
  print("Custo total: ${custoTotalDaViagem.toStringAsFixed(2)}");
  print("Custo por km: ${custoporKmRodado.toStringAsFixed(2)}");
}
