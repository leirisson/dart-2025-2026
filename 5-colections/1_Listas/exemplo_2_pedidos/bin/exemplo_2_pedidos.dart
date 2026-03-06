void main(List<String> arguments) {
  List<String> pedidos = <String>[];
  pedidos.add("pizza");
  pedidos.add("hamburger");
  pedidos.add("bolo");
  pedidos.add("café");

  if(pedidos.contains("pizza")){
    print("Pedido confirmado.");
  }

  print("Total de pedidos: ${pedidos.length}");
}
