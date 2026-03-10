
import 'package:exemplo_3_veiculo/Veiculo.dart';

class Carro extends Veiculo {
  Carro(super.modelo);

  @override // significa sobreescrever metodo
  void ligar(){
    print("Ligado ... 🎉");
  }
}