

void main() {
  List<String>  listaDecompras = ['arroz', 'feijão', 'leite'];

  // adicionando item na lista
  listaDecompras.add('café');

  // removendo item da lista
  listaDecompras.remove('feijão');

  
  //percorrendo alista
  for(String item in listaDecompras){
    print("produto: $item");
  }
}
