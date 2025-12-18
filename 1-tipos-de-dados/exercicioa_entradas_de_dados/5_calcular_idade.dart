import "dart:io";

// Exercício 5 – Cálculo de idade
// Declare o ano de nascimento
// Declare o ano atual
// Calcule a idade

void main(){
  // capturando o ano atual
  int ano_atual = new DateTime.now().year;

  print("informe o seu ano de nascimento: ");
  int ano_nascimento = int.parse(stdin.readLineSync()!);

  int idade = ano_atual - ano_nascimento;

  print("idade atual é: $idade");
}