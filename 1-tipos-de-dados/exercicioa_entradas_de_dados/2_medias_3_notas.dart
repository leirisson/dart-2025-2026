import "dart:io";

// 🔹 Exercício 2 – Média de três notas
// Declare três notas
// Calcule a média
// Exiba a média

void main(){
  print("digite a primeira nota: ");
  double nota1 = double.parse(stdin.readLineSync()!);

  print("digite a segunda nota: ");
  double nota2 = double.parse(stdin.readLineSync()!);
  
  print("digite a 3º nota: ");
  double nota3 = double.parse(stdin.readLineSync()!);

  double media = (nota1 + nota2 + nota3) / 3;

  if(media >= 6){
    print("APROVADO.");
    print("MÉDIA: $media");
  } else if (media < 6){
    print("Reprovado.");
    print("MÉDIA: $media");
  } else {
    print("APROVADO.");
    print("MÉDIA: $media");
  }

}