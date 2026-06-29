import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../database/database.dart';
import '../models/pedido.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final pedidosProvider = StreamProvider<List<Pedido>>((ref) {
  return ref.watch(databaseProvider).watchTodos();
});

class PedidoNotifier extends Notifier<void> {
  @override
  void build() {}

  AppDatabase get _db => ref.read(databaseProvider);

  Future<void> criar({
    required String cliente,
    required String itens,
    String? observacao,
  }) {
    return _db.inserir(
      PedidosCompanion(
        cliente: Value(cliente),
        itens: Value(itens),
        observacao: Value(observacao),
      ),
    );
  }

  Future<void> atualizarStatus(Pedido pedido, StatusPedido novoStatus) {
    return _db.atualizar(
      pedido.copyWith(status: novoStatus.name),
    );
  }

  Future<void> deletar(int id) => _db.deletar(id);
}

final pedidoNotifierProvider =
    NotifierProvider<PedidoNotifier, void>(PedidoNotifier.new);
