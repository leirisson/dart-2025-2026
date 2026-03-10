
import 'package:ex3_sistema_de_pagamentos/CreditCardPayment.dart';
import 'package:ex3_sistema_de_pagamentos/Payment.dart';
import 'package:ex3_sistema_de_pagamentos/PixPayment.dart';




void main() {
List<Payment> payments = [
  CreditCardPayment(500, 5),
  PixPayment(200, "email@pix.com")
];

for (Payment payment in payments) {
  payment.processPayment();
}

}
