class Conta {
  double _saldo = 0;

  double get saldo => _saldo;

  void depositar(double valor){
    _saldo += valor;
  }

  void sacar(double valor){
    if(_saldo >= valor){
      _saldo -= valor;
    } else {
      print("Saldo insuficiente.");
    }
  }
}