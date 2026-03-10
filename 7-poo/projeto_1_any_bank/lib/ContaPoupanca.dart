import 'package:projeto_1_any_bank/Conta.dart';

class ContaPoupanca extends Conta {
  double redimento = 0.05;
  double _saldo = 0;

  ContaPoupanca(super.titular, super._saldo);

  void calculaRedimento(){
    _saldo += (_saldo * redimento);
  }
}