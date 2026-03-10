
import 'package:ex4_sistema_de_notificacoes/Notification.dart';

class EmailNotification extends Notification{
  String email;
  EmailNotification(super.message, this.email);

  @override
  void send(){
    print("Eniando EMAIL para $email: $message");
  }
}