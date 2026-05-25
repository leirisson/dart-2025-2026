
class Usuario {
  String nome;
  final String _senha;

  // metodo construtor
  Usuario(this.nome, this._senha);

  bool authenticar(String senhaDigitada){
    return senhaDigitada == _senha;
  }

  
}