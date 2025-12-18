import "dart:io";

// 🔹 Exercício 1 – Dobro de um número
// Crie um programa que:
// Declare um número
// Calcule o dobro
// Exiba o resultado

void main(){
  print("informe um valor: ");
  double numero = double.parse(stdin.readLineSync()!);

  double dobro_valor = numero * 2;
  print("O dobro do valor é: $dobro_valor");
}
