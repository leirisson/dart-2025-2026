
import 'package:ex4_sistema_de_notificacoes/EmailNotification.dart';
import 'package:ex4_sistema_de_notificacoes/Notification.dart';
import 'package:ex4_sistema_de_notificacoes/SmsNotification.dart';


void main(List<String> arguments) {
  List<Notification> notifications = [];
  EmailNotification emailNotification = EmailNotification("Bom dia, vamos almoçar que horas hoje ?", "leriisson.example.com");
  SmsNotification smsNotification = SmsNotification("Bom dia, já comprou os novos produtos ?", "+5592995963268");

  notifications.add(emailNotification);
  notifications.add(smsNotification);

  for(Notification notification in notifications){
    notification.send();
  }
}
