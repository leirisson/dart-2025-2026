import 'package:projeto_1_any_bank/Conta.dart';
import 'package:projeto_1_any_bank/ContaPoupanca.dart';

void main(List<String> arguments) {
  
  ContaPoupanca contaLeirisson = ContaPoupanca("Leirisson", 1500);
  ContaCorrente contaMaria = ContaCorrente("Maria", 1000);

  List<Conta> contas = <Conta>[contaLeirisson, contaMaria];

  for (Conta conta in contas) {
    conta.imprimirSaldo();
  }


  // contaMaria.enviar(1300);
  // contaLeirisson.enviar(1800);

}


