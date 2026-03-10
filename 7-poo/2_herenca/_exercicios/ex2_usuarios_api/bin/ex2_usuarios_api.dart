import 'package:ex2_usuarios_api/AdminUser.dart';
import 'package:ex2_usuarios_api/CustomerUser.dart';


void main(List<String> arguments) {
  AdminUser userAdmin = AdminUser("Leirisson", "leirisson.exaple.com", "admin");
  CustomerUser custumer = CustomerUser("Maria", "maria.exaple.com", 0);

  // exibindo as informações
  print(""); 
  print("INFORMAÇÕES DOS USUARIOS");
  userAdmin.showInfo();
  custumer.showInfo();

  //deltando um usuario com admin
  print("");
  print("DELETANDO UM USUARIO");
  userAdmin.deleteUser();

  // realizando venda 
  print("");
  print("REALIZANDO VENDAS");
  custumer.makePurchaseCount();
  custumer.makePurchaseCount();
}
