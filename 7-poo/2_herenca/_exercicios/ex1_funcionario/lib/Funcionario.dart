class Funcionario {
  String nome;
  double _salario = 0;

  Funcionario(this.nome, this._salario);

  // Getter: Permite LER o valor de _salario
  // ignore: unnecessary_getters_setters
  double get salario => _salario;

  // Setter: Permite ALTERAR o valor de _salario
  set salario(double valor) {
    _salario = valor;
  }
  void calcularSalario() {}
  void imprimirInfo() {}
}
