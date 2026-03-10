import 'package:ex6_sistema_de_logs/Log.dart';

class Errorlog extends Log {
  String erroCode;
  Errorlog(super.message, super.timestamp, this.erroCode);

  @override
  void write(){
    print("[ERROR] [$timestamp] $message (code: $erroCode)");
  }
}
