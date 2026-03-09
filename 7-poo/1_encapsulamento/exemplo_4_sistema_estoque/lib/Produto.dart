

class Produto {
  String nome;
  int _estoque;

  Produto(this.nome, this._estoque);

  void vender(int quantidade){
    if(quantidade <= _estoque){
      _estoque -= quantidade;
      print("Venda realizada !");
    } else {
      print("Estoque insuficiente");
    }
  }

  int consultarEstoque(){
    return _estoque;
  }
}