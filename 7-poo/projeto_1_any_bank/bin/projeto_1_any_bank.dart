void main(List<String> arguments) {
  Conta contaMatheus = Conta("Matheus", 1000);
  Conta contaRoberta = Conta("Roberta", 2000);

  List<Conta> contas = <Conta>[contaMatheus, contaRoberta];

  for (Conta conta in contas) {
    print("");
    print("=============================");
    print(conta.titular);
    print(conta.saldo);
  }

  receber(contaMatheus, 500);
  print(contaMatheus.saldo);

  enviarDinheiro(contaMatheus, 150);
  print(contaMatheus.saldo);
}



void receber(Conta conta, double valor){
  conta.saldo += valor;
}

void enviarDinheiro(Conta contaOrigem, double valor){
  contaOrigem.saldo -= valor;
}

class Conta {
  String titular;
  double saldo;

  Conta(this.titular, this.saldo);


}
