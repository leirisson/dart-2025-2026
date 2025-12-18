import "dart:ffi";
import "dart:io";

// 🔹 Exercício 4 – Valor total da compra
// Contexto: Uma loja vende um produto.
// Preço do produto
// Quantidade comprada
// Calcular valor total

void main(){

  print("quantidade do produto: ");
  double quantidade = double.parse(stdin.readLineSync()!);

  print("valor do produto: ");
  double valor_produto = double.parse(stdin.readLineSync()!);

  double valor_total = valor_produto * quantidade;

  print("VALOR TOTAL DA COMPRA: $valor_total R\$");
}