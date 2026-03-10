abstract class Conta {
  String titular;
  double _saldo;

  Conta(this.titular, this._saldo);

  void receber(double valor) {
    _saldo += valor;
    imprimirSaldo();
  }

  void enviar(double valor) {
    if (_saldo >= valor) {
      _saldo -= valor;
    }
    imprimirSaldo();
  }

  void imprimirSaldo() {
    print("O saldo atual do titular: $titular é saldo: $_saldo");
  }
}

class ContaCorrente extends Conta {
  double emprestimo = 300;
  ContaCorrente(super.titula, super._saldo);

  @override
  void enviar(double valor){
    if(_saldo + emprestimo >= valor){
      _saldo -= valor;
      imprimirSaldo();
    } 
  }
}


