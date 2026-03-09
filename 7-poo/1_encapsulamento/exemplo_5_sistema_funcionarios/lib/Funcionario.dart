
class Funcionario {
  String nome;
  double _salario;

  Funcionario(this.nome, this._salario);

  void aumentarSalario(double percetual){
    _salario += _salario * (percetual / 100);
  }


  double consultarSalario(){
    return _salario;
  }
}