

import 'package:ex3_sistema_de_pagamentos/Payment.dart';

class CreditCardPayment extends Payment{
  int installment;
  CreditCardPayment(super.amount, this.installment);

  @override
  void processPayment(){
    print("Pagamento de $amount reais no cartão em $installment parcelas");
  }
}