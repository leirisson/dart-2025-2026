
void main() {
  Map<String, dynamic> produtos = {
    'nome':'Notebook',
    'preco':3500,
    'estoque':100,
    'ativo':true
  };

  if(produtos['ativo'] == true){
    print("Está ativo");
  }
  print(produtos['ativo']);
}
