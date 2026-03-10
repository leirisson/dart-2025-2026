

import 'package:ex2_usuarios_api/User.dart';

class AdminUser extends User{
  String accessLevel;
  AdminUser(super.name, super.email, this.accessLevel);

  void deleteUser(){
    print("Usuário deletado pelo admin");
  }

  @override
  void showInfo(){
    print("name: $name | e-mail: $email | access: $accessLevel");
  }
}