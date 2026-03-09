
class Produto {
  double _preco = 0;

  double get preco => _preco;

  set preco(double valor) {
    if (valor > 0) {
      _preco = valor;
    }
  }
}
