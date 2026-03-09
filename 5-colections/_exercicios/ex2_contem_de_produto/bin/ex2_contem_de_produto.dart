void main() {
  final produtos = [
    {"nome": "Notebook", "categoria": "eletronico"},
    {"nome": "Mouse", "categoria": "eletronico"},
    {"nome": "Teclado", "categoria": "eletronico"},
    {"nome": "Cadeira", "categoria": "moveis"},
    {"nome": "Mesa", "categoria": "moveis"},
    {"nome": "Caneta", "categoria": "papelaria"},
  ];

  contagemProdutosPorCategoria(produtos);
}

// indentificar categorias unicas

Map<String, int> contagemProdutosPorCategoria(
  List<Map<String, String>> produtos,
) {
  Map<String, int> qtdProCategoria = {};
  Set<String> cat = {};

  int contador = 0;
  int indexCategoria = 0;

  for (var produto in produtos) {
    cat.add(produto['categoria']!);
  }



  return qtdProCategoria;
}
