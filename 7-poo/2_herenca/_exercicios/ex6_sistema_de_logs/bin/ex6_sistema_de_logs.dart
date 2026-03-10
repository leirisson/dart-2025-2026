
import 'package:ex6_sistema_de_logs/ErrorLog.dart';
import 'package:ex6_sistema_de_logs/InfoLog.dart';
import 'package:ex6_sistema_de_logs/Log.dart';




void main() {
  
  List<Log> erros = [
    Errorlog("Erro na bomva de combustivel", "20152025", "205"),
    Infolog("Bateria vai descarregar em 2H", "21122026", "monitoramento da bateria")
  ];


  for(Log log in erros){
    log.write();
  }
}
