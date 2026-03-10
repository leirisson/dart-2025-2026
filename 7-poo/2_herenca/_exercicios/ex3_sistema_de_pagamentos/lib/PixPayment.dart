
import 'package:ex3_sistema_de_pagamentos/Payment.dart';

class PixPayment extends Payment {
  String pixKey;
  PixPayment(super.amount, this.pixKey);

  @override
  void processPayment(){
    print("Pagamento de $amount reais via PIX para chave $pixKey");
  }
}