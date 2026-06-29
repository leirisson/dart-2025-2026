import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

class Pedidos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get cliente => text()();
  TextColumn get itens => text()();
  TextColumn get observacao => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('novo'))();
  DateTimeColumn get criadoEm => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [Pedidos])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'pedidos_db');
  }

  Future<List<Pedido>> listarTodos() => select(pedidos).get();

  Stream<List<Pedido>> watchTodos() => select(pedidos).watch();

  Future<int> inserir(PedidosCompanion pedido) =>
      into(pedidos).insert(pedido);

  Future<bool> atualizar(Pedido pedido) =>
      update(pedidos).replace(pedido);

  Future<int> deletar(int id) =>
      (delete(pedidos)..where((t) => t.id.equals(id))).go();
}
