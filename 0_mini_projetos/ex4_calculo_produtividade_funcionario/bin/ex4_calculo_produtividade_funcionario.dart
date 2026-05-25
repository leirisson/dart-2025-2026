// Exercício 4 — Cálculo de Produtividade do Funcionário
// Uma empresa quer medir produtividade.
// 📌 O funcionário informa:
// Quantidade de tarefas concluídas
// Total de horas trabalhadas
// 🎯 O sistema deve calcular:
// Média de tarefas por hora
// Total estimado de tarefas se ele trabalhasse 160 horas no mês

/// EXPLICAÇÃO DO CODIGO
/// 1. VOU DECLARAR AS VARIAVEIS RESPONSAVEIS POR AMAZEBAR AS
/// HORAS TRABALHADAS E TAREFAS CONCLUIDAS
/// 2.CAPTURAR OS DADOS DO USUASRIO
/// 4. CALCULAR A MÉDIA DE TAREFAS POR HORA
/// 5. EXIBIR O RESUDATO NO TERMINAL.
library;


import 'dart:io';

void main() {
  int tarefasConcluidas = 0;
  double totoalDeHorasTrabalhadas = 0;
  double mediaTarefasPorHoras = 0;
  double estimativa = 0;

  print("quantas tarefas foram concluidas ?:");
  tarefasConcluidas = int.parse(stdin.readLineSync()!);

  print("quntas horas você gastou ?: ");
  totoalDeHorasTrabalhadas = double.parse(stdin.readLineSync()!);

  mediaTarefasPorHoras = tarefasConcluidas / totoalDeHorasTrabalhadas;
  estimativa = mediaTarefasPorHoras * 60;

  print("Média por hora: $mediaTarefasPorHoras");
  print("Estimativa para 160h: $estimativa");


}
