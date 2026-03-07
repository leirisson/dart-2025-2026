void main() {
  final usuarios = [
    {"id": 1, "nome": "Ana", "ativo": true},
    {"id": 2, "nome": "Carlos", "ativo": false},
    {"id": 3, "nome": "Mariana", "ativo": true},
    {"id": 4, "nome": "João", "ativo": false},
    {"id": 5, "nome": "Fernanda", "ativo": true},
  ];

  var usuariosAtivos = buscarUsuariosAtivos(usuarios);

  print(usuariosAtivos);
}

List<Map<String, dynamic>> buscarUsuariosAtivos(
  List<Map<String, dynamic>> usuarios,
) {
  List<Map<String, dynamic>> usuariosAtivos = [];

  for (var usuario in usuarios) {
    if (usuario['ativo']) {
      usuariosAtivos.add(usuario);
    }
  }

  return usuariosAtivos;
}
