
import 'dart:io';
import 'package:exemplo_3_usuario_senha_privada/Usuario.dart';

void main() {
  Usuario usuario = Usuario("Leirisson", "123456");

  String senha;

  print("Qual a sua senha: ");
  senha = stdin.readLineSync()!;

  if(usuario.authenticar(senha)){
    print("Usuário logado com sucesso ✅🎉");
  } else {
    print("usuário ou senha incorreto. ❌");
  }
  
}
