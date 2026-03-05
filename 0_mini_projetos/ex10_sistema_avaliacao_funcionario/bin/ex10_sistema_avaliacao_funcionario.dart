import 'dart:io';

// 🟢 Exercício 9 — Sistema de Avaliação de Funcionário
// Uma empresa avalia seus funcionários pela média de produtividade.
// 📌 O sistema recebe:
// quantidade de tarefas concluídas
// horas trabalhadas



void main() {
  int tarefasConcluidas = 0;
  double horasTrablhadas = 0;
  double produtividade = 0;
  String mensagem = "";

  print("Quantidade de tarefas concluidas: ");
  tarefasConcluidas = int.parse(stdin.readLineSync()!);

  print("Quantidade de horas trabalhadas: ");
  horasTrablhadas = double.parse(stdin.readLineSync()!);

  produtividade = tarefasConcluidas / horasTrablhadas;

  if (produtividade < 1) {
    mensagem = "Baixa produtividade";
  } else if(produtividade >=1 && produtividade <=2){
    mensagem="Produtividade normal";
  } else {
    mensagem="Alta produtividade";
  }

  print("Produtividade: $produtividade");
  print("Classificação: $mensagem");
}
