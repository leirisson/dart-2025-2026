import 'dart:io';

// 🟢 Exercício 8 — Sistema de Desconto de Loja
// Uma loja aplica desconto dependendo do valor da compra.
// 📌 Regras
// Valor da compra	Desconto
// até 100	0%
// 100 a 500	10%
// acima de 500	20%

// 🎯 O sistema deve mostrar:
// valor da compra
// percentual de desconto
// valor do desconto
// valor final a pagar

/// EXPLICAÇÃO:
/// IDENTIFIQUEI QUE PREICISO QUE PRECISAVA ARMAZENAR: valorCompra, desconto, valorDesconto, valorFinal
/// DEPOIS PRECISAVA CAPTURAR A INFORMAÇÃO DO USUARIO, QUE É O VALOR DA COMPRA
/// PARA PODER REALIZAR OS CALCULOS E VERIFICAR SE É PARA APLICAR OS DESCONTOS 
/// COM BASE NO VALOR DA COMPRA
/// VERIFICO SE O VALOR DA COMPRA É COMPATIVEL COM O VALOR ONDE SE APLICA O DESCONTO SE SIM APLICA O DESCONTO
/// CORRETO SE NÃO aplica e exibe uma mensagem
/// calcular o desconto
/// e por ultimo formatar e exibir par ao usuario.
void main() {
  double valorCompra = 0;
  double desconto = 0;
  double valorDesconto = 0;
  double valorFinal = 0;

  print("Qual o valor da compra: ");
  valorCompra = double.parse(stdin.readLineSync()!);

  if (valorCompra < 100) {
    desconto = 0;
  } else if (valorCompra >= 100 && valorCompra <= 500) {
    desconto = 0.10;
  } else {
    desconto = 0.20;
  }

  valorDesconto = valorCompra * desconto;
  valorFinal = valorCompra - valorDesconto;

  print("Valor da compra: ${valorCompra.toStringAsFixed(2)}");
  print("Desconto aplicado: ${(desconto * 100)}%");
  print("Valor do desconto: ${valorDesconto.toStringAsFixed(2)}");
  print("ValorFinal: ${valorFinal.toStringAsFixed(2)}");
}
