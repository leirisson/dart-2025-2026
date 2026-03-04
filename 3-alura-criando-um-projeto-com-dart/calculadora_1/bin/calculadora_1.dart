import 'dart:io';

void main() {
  print("Informe o primeiro valor: ");
  double numeroUm = double.parse(stdin.readLineSync()!);
  print("informe o segundo valor: ");
  double numerodois = double.parse(stdin.readLineSync()!);


 void soma(){
  print(numeroUm + numerodois);
 }

 void subtracao(){
  print(numeroUm - numerodois);
 }

 void divisao(){
  print(numeroUm / numerodois);
 }

 void mutiplicacao(){
  print(numeroUm * numerodois);
 }

 print("Escolha uma opção: ");
 print("1. soma");
 print("2. subtrção");
 print("3. divisão");
 print("4. muitiplicação");

 String operacao = stdin.readLineSync()!;

 switch(operacao){
  case "1":
    soma();
  case "2":
    subtracao();
  case "3":
    divisao();
  case "4":
    mutiplicacao();
 }

}
