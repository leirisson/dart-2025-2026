import 'dart:io';

void main() {
  print("Informe o primeiro valor: ");
  double numero1 = double.parse(stdin.readLineSync()!);
  print("informe o segundo valor: ");
  double numero2 = double.parse(stdin.readLineSync()!);

  var soma = (numero1 + numero2);

  print("A soma de $numero1 + $numero2 = $soma");
}
