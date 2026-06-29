enum StatusPedido { novo, emPreparo, entregue }

extension StatusPedidoExt on StatusPedido {
  String get label {
    switch (this) {
      case StatusPedido.novo:
        return 'Novo';
      case StatusPedido.emPreparo:
        return 'Em Preparo';
      case StatusPedido.entregue:
        return 'Entregue';
    }
  }
}
