import 'dart:io';

// 🟢 Exercício 7 — Cálculo de Bônus de Funcionário
// Uma empresa paga bônus por produtividade.
// 📌 Regras:
// Se o funcionário vender mais de 10.000 no mês
// → ganha bônus de 10%
// Caso contrário
// → ganha bônus de 5%

/// EXPLICAÇÃO DA RESOLUÇÃO:
/// DECLARAR AS VARIAVEIS [X]
/// RECEBER O VALOR TOTAL DAS VENDAS DO MES
/// verificar se o valor da venda do mes é maior que 10000 ou menor 
/// para aplicar o bonus e realizar o calculo
/// exibir o resultado formatado pro usuario;

void main() {
  double totalVendasDoMes = 0;
  double bonus = 0;
  double valorDoBonus = 0;

  print("Qual totoal das vendas do mes ?: ");
  totalVendasDoMes = double.parse(stdin.readLineSync()!);

  if (totalVendasDoMes >= 10000) {
    bonus = 0.10;
  } else {
    bonus = 0.05;
  }

  valorDoBonus = totalVendasDoMes * bonus;

  print("valor total vendido: ${totalVendasDoMes.toStringAsFixed(2)}");
  print("percentual de bônus aplicado: ${(bonus * 100).toStringAsFixed(0)}%");
  print("valor do bônus: $valorDoBonus");
}
