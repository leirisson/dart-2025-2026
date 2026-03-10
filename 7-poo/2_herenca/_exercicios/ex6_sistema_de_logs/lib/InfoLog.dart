

import 'package:ex6_sistema_de_logs/Log.dart';

class Infolog extends Log{
  String service;
  
  Infolog(super.message, super.timestamp, this.service);

  @override
  void write(){
    print("[INFO] [$timestamp] $message (service: $service)");
  }
}