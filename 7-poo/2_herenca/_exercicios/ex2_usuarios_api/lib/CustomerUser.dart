


import 'package:ex2_usuarios_api/User.dart';

class CustomerUser extends User {
  int purchaseCount =0;
  CustomerUser(super.name, super.email, this.purchaseCount);

  void makePurchaseCount(){
    purchaseCount++;
    print("Compra realizada. Total de compras: $purchaseCount");
  }

  @override
  void showInfo(){
    print("name: $name | e--mail: $email | purchaseCount: $purchaseCount");
  }

}