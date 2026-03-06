import 'dart:io';

void main() {
  double numeroUm = 0;
  double numerodois = 0;
  String? entrada = "";
  String operacao = "";
  List<String> operacoes = <String>["+", "-", "/", "*"];

  void soma() {
    print(numeroUm + numerodois);
  }

  void subtracao() {
    print(numeroUm - numerodois);
  }

  void divisao() {
    print(numeroUm / numerodois);
  }

  void mutiplicacao() {
    print(numeroUm * numerodois);
  }

  // ignore: unused_element
  void getOperacao() {
    print("Digite uma opração: ");
    entrada = stdin.readLineSync()!;
    if (entrada != null) {
      if (operacoes.contains(entrada)) {
        operacoes = entrada as List<String>;
      }
    }
  }

  print("Escolha uma opção: ");
  print("1. soma");
  print("2. subtrção");
  print("3. divisão");
  print("4. muitiplicação");
  operacao = stdin.readLineSync()!;

  switch (operacao) {
    case "1":
      print("digite o primeiro valor: ");
      entrada = stdin.readLineSync()!;

      if (entrada != "") {
        numeroUm = double.parse(entrada!);
      }

      print("digite o segundo valor: ");
      entrada = stdin.readLineSync()!;
      if (entrada != "") {
        numerodois = double.parse(entrada!);
      }
      soma();
    case "2":
      print("digite o primeiro valor: ");
      entrada = stdin.readLineSync()!;

      if (entrada != "") {
        numeroUm = double.parse(entrada!);
      }

      print("digite o segundo valor: ");
      entrada = stdin.readLineSync()!;
      if (entrada != "") {
        numerodois = double.parse(entrada!);
      }
      subtracao();
    case "3":
      print("digite o primeiro valor: ");
      entrada = stdin.readLineSync()!;

      if (entrada != "") {
        numeroUm = double.parse(entrada!);
      }

      print("digite o segundo valor: ");
      entrada = stdin.readLineSync()!;
      if (entrada != "") {
        numerodois = double.parse(entrada!);
      }
      divisao();
    case "4":
      print("digite o primeiro valor: ");
      entrada = stdin.readLineSync()!;

      if (entrada != "") {
        numeroUm = double.parse(entrada!);
      }

      print("digite o segundo valor: ");
      entrada = stdin.readLineSync()!;
      if (entrada != "") {
        numerodois = double.parse(entrada!);
      }
      mutiplicacao();
      break;
  }
}
