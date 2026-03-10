


import 'package:ex4_sistema_de_notificacoes/Notification.dart';

class SmsNotification extends Notification {
  String phoneNumber;
  SmsNotification(super.message, this.phoneNumber);

  @override
  void send(){
    print("Enviando SMS para $phoneNumber: $message");
  }
}