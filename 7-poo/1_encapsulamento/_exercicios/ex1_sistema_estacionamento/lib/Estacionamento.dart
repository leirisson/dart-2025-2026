class Estacionamento {
  int _vagas = 0;

  Estacionamento(this._vagas);

  void entrarCarro(int quantidadeCarro) {
    if (_vagas > 0) {
      _vagas -= quantidadeCarro;
    } else {
      print("Não tem vaga disponivel.");
    }
  }

  void sairCarro(int quantidadeCarro) {
    if (_vagas == 20) {
      print("todas as vagas já estão livres.");
    } else if (_vagas < 20) {
      _vagas += quantidadeCarro;
    }
  }

  int consultarVagas() {
    return _vagas;
  }


}
