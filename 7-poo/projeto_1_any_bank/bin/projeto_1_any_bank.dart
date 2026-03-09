import 'package:projeto_1_any_bank/Conta.dart';

void main(List<String> arguments) {
  Conta contaMatheus = Conta("Matheus", 1000);
  Conta contaRoberta = Conta("Roberta", 2000);

  List<Conta> contas = <Conta>[contaMatheus, contaRoberta];

  for (Conta conta in contas) {
    print("");
    print("=============================");
    print(conta.titular);
  }

  contaMatheus.receber(500);


  contaMatheus.enviarDinheiro(150);

}


