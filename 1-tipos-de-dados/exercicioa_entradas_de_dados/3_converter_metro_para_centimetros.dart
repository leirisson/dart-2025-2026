import "dart:io";

// 🔹 Exercício 3 – Conversão de metros para centímetros
// Declare um valor em metros
// Converta para centímetros
// Mostre o resultado

void main(){
  print("informe a distancias em METROS: ");
  double metros = double.parse(stdin.readLineSync()!);

  double centimetros = metros * 100;

  print("Distancia convertida com sucesso.");
  print("DISTANCIA EM METROS: $metros M");
  print("distancia em centimetros: $centimetros cm");
}