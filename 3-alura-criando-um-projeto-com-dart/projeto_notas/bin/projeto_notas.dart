import 'dart:io';

void main() {
  List<String> notas = <String>[];
  menu(notas);
}

String getComando() {
  print("Digite um comando: ");
  print("1 - Adicionar notas");
  print("2 - Listar notas");
  print("3 - Sair");
  List<String> comandos = <String>["1", "2", "3"];
  String? entrada = "";

  entrada = stdin.readLineSync();

  if (entrada == null || !comandos.contains(entrada)) {
    print("Comando invalido");
    getComando();
  }

  return entrada!;
}

List<String> adicionarNotas(List<String> notas) {
  print("Escreva uma nota: ");

  String? nota = "";
  nota = stdin.readLineSync();

  if (nota == null || nota.isEmpty) {
    print("Não é possivel adicionar uma nota vazia.");
    adicionarNotas(notas);
  }

  notas.add(nota!);

  return notas;
}

void ListarNotas(List<String> notas) {
  print("Notas cadastradas: ");
  for (var i = 0; i < notas.length; i++) {
    print(notas[i]);
  }
}

void menu(List<String> notas) {
  print("");

  cabecalho();

  print("");
  String comando = getComando();
  print("");
  switch (comando) {
    case "1":
      adicionarNotas(notas);
      menu(notas);
    case "2":
      ListarNotas(notas);
      menu(notas);
    case "3":
      print("Saindo...");
  }
}

void cabecalho() {
  print("@@\   @@\             @@\                         ");
  print("@@@\  @@ |            @@ |                        ");
  print("@@@@\ @@ | @@@@@@\  @@@@@@\    @@@@@@\   @@@@@@@\ ");
  print("@@ @@\@@ |@@  __@@\ \_@@  _|   \____@@\ @@  _____|");
  print("@@ \@@@@ |@@ /  @@ |  @@ |     @@@@@@@ |\@@@@@@\  ");
  print("@@ |\@@@ |@@ |  @@ |  @@ |@@\ @@  __@@ | \____@@\ ");
  print("@@ | \@@ |\@@@@@@  |  \@@@@  |\@@@@@@@ |@@@@@@@  |");
  print("\__|  \__| \______/    \____/  \_______|\_______/ ");
}
