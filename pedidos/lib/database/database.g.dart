// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PedidosTable extends Pedidos with TableInfo<$PedidosTable, Pedido> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PedidosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clienteMeta =
      const VerificationMeta('cliente');
  @override
  late final GeneratedColumn<String> cliente = GeneratedColumn<String>(
      'cliente', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _itensMeta = const VerificationMeta('itens');
  @override
  late final GeneratedColumn<String> itens = GeneratedColumn<String>(
      'itens', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _observacaoMeta =
      const VerificationMeta('observacao');
  @override
  late final GeneratedColumn<String> observacao = GeneratedColumn<String>(
      'observacao', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('novo'));
  static const VerificationMeta _criadoEmMeta =
      const VerificationMeta('criadoEm');
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
      'criado_em', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, cliente, itens, observacao, status, criadoEm];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pedidos';
  @override
  VerificationContext validateIntegrity(Insertable<Pedido> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cliente')) {
      context.handle(_clienteMeta,
          cliente.isAcceptableOrUnknown(data['cliente']!, _clienteMeta));
    } else if (isInserting) {
      context.missing(_clienteMeta);
    }
    if (data.containsKey('itens')) {
      context.handle(
          _itensMeta, itens.isAcceptableOrUnknown(data['itens']!, _itensMeta));
    } else if (isInserting) {
      context.missing(_itensMeta);
    }
    if (data.containsKey('observacao')) {
      context.handle(
          _observacaoMeta,
          observacao.isAcceptableOrUnknown(
              data['observacao']!, _observacaoMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('criado_em')) {
      context.handle(_criadoEmMeta,
          criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Pedido map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pedido(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      cliente: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cliente'])!,
      itens: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}itens'])!,
      observacao: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}observacao']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      criadoEm: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}criado_em'])!,
    );
  }

  @override
  $PedidosTable createAlias(String alias) {
    return $PedidosTable(attachedDatabase, alias);
  }
}

class Pedido extends DataClass implements Insertable<Pedido> {
  final int id;
  final String cliente;
  final String itens;
  final String? observacao;
  final String status;
  final DateTime criadoEm;
  const Pedido(
      {required this.id,
      required this.cliente,
      required this.itens,
      this.observacao,
      required this.status,
      required this.criadoEm});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cliente'] = Variable<String>(cliente);
    map['itens'] = Variable<String>(itens);
    if (!nullToAbsent || observacao != null) {
      map['observacao'] = Variable<String>(observacao);
    }
    map['status'] = Variable<String>(status);
    map['criado_em'] = Variable<DateTime>(criadoEm);
    return map;
  }

  PedidosCompanion toCompanion(bool nullToAbsent) {
    return PedidosCompanion(
      id: Value(id),
      cliente: Value(cliente),
      itens: Value(itens),
      observacao: observacao == null && nullToAbsent
          ? const Value.absent()
          : Value(observacao),
      status: Value(status),
      criadoEm: Value(criadoEm),
    );
  }

  factory Pedido.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pedido(
      id: serializer.fromJson<int>(json['id']),
      cliente: serializer.fromJson<String>(json['cliente']),
      itens: serializer.fromJson<String>(json['itens']),
      observacao: serializer.fromJson<String?>(json['observacao']),
      status: serializer.fromJson<String>(json['status']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cliente': serializer.toJson<String>(cliente),
      'itens': serializer.toJson<String>(itens),
      'observacao': serializer.toJson<String?>(observacao),
      'status': serializer.toJson<String>(status),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
    };
  }

  Pedido copyWith(
          {int? id,
          String? cliente,
          String? itens,
          Value<String?> observacao = const Value.absent(),
          String? status,
          DateTime? criadoEm}) =>
      Pedido(
        id: id ?? this.id,
        cliente: cliente ?? this.cliente,
        itens: itens ?? this.itens,
        observacao: observacao.present ? observacao.value : this.observacao,
        status: status ?? this.status,
        criadoEm: criadoEm ?? this.criadoEm,
      );
  Pedido copyWithCompanion(PedidosCompanion data) {
    return Pedido(
      id: data.id.present ? data.id.value : this.id,
      cliente: data.cliente.present ? data.cliente.value : this.cliente,
      itens: data.itens.present ? data.itens.value : this.itens,
      observacao:
          data.observacao.present ? data.observacao.value : this.observacao,
      status: data.status.present ? data.status.value : this.status,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pedido(')
          ..write('id: $id, ')
          ..write('cliente: $cliente, ')
          ..write('itens: $itens, ')
          ..write('observacao: $observacao, ')
          ..write('status: $status, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, cliente, itens, observacao, status, criadoEm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pedido &&
          other.id == this.id &&
          other.cliente == this.cliente &&
          other.itens == this.itens &&
          other.observacao == this.observacao &&
          other.status == this.status &&
          other.criadoEm == this.criadoEm);
}

class PedidosCompanion extends UpdateCompanion<Pedido> {
  final Value<int> id;
  final Value<String> cliente;
  final Value<String> itens;
  final Value<String?> observacao;
  final Value<String> status;
  final Value<DateTime> criadoEm;
  const PedidosCompanion({
    this.id = const Value.absent(),
    this.cliente = const Value.absent(),
    this.itens = const Value.absent(),
    this.observacao = const Value.absent(),
    this.status = const Value.absent(),
    this.criadoEm = const Value.absent(),
  });
  PedidosCompanion.insert({
    this.id = const Value.absent(),
    required String cliente,
    required String itens,
    this.observacao = const Value.absent(),
    this.status = const Value.absent(),
    this.criadoEm = const Value.absent(),
  })  : cliente = Value(cliente),
        itens = Value(itens);
  static Insertable<Pedido> custom({
    Expression<int>? id,
    Expression<String>? cliente,
    Expression<String>? itens,
    Expression<String>? observacao,
    Expression<String>? status,
    Expression<DateTime>? criadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cliente != null) 'cliente': cliente,
      if (itens != null) 'itens': itens,
      if (observacao != null) 'observacao': observacao,
      if (status != null) 'status': status,
      if (criadoEm != null) 'criado_em': criadoEm,
    });
  }

  PedidosCompanion copyWith(
      {Value<int>? id,
      Value<String>? cliente,
      Value<String>? itens,
      Value<String?>? observacao,
      Value<String>? status,
      Value<DateTime>? criadoEm}) {
    return PedidosCompanion(
      id: id ?? this.id,
      cliente: cliente ?? this.cliente,
      itens: itens ?? this.itens,
      observacao: observacao ?? this.observacao,
      status: status ?? this.status,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cliente.present) {
      map['cliente'] = Variable<String>(cliente.value);
    }
    if (itens.present) {
      map['itens'] = Variable<String>(itens.value);
    }
    if (observacao.present) {
      map['observacao'] = Variable<String>(observacao.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PedidosCompanion(')
          ..write('id: $id, ')
          ..write('cliente: $cliente, ')
          ..write('itens: $itens, ')
          ..write('observacao: $observacao, ')
          ..write('status: $status, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PedidosTable pedidos = $PedidosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [pedidos];
}

typedef $$PedidosTableCreateCompanionBuilder = PedidosCompanion Function({
  Value<int> id,
  required String cliente,
  required String itens,
  Value<String?> observacao,
  Value<String> status,
  Value<DateTime> criadoEm,
});
typedef $$PedidosTableUpdateCompanionBuilder = PedidosCompanion Function({
  Value<int> id,
  Value<String> cliente,
  Value<String> itens,
  Value<String?> observacao,
  Value<String> status,
  Value<DateTime> criadoEm,
});

class $$PedidosTableFilterComposer
    extends Composer<_$AppDatabase, $PedidosTable> {
  $$PedidosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cliente => $composableBuilder(
      column: $table.cliente, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itens => $composableBuilder(
      column: $table.itens, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnFilters(column));
}

class $$PedidosTableOrderingComposer
    extends Composer<_$AppDatabase, $PedidosTable> {
  $$PedidosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cliente => $composableBuilder(
      column: $table.cliente, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itens => $composableBuilder(
      column: $table.itens, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
      column: $table.criadoEm, builder: (column) => ColumnOrderings(column));
}

class $$PedidosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PedidosTable> {
  $$PedidosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cliente =>
      $composableBuilder(column: $table.cliente, builder: (column) => column);

  GeneratedColumn<String> get itens =>
      $composableBuilder(column: $table.itens, builder: (column) => column);

  GeneratedColumn<String> get observacao => $composableBuilder(
      column: $table.observacao, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);
}

class $$PedidosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PedidosTable,
    Pedido,
    $$PedidosTableFilterComposer,
    $$PedidosTableOrderingComposer,
    $$PedidosTableAnnotationComposer,
    $$PedidosTableCreateCompanionBuilder,
    $$PedidosTableUpdateCompanionBuilder,
    (Pedido, BaseReferences<_$AppDatabase, $PedidosTable, Pedido>),
    Pedido,
    PrefetchHooks Function()> {
  $$PedidosTableTableManager(_$AppDatabase db, $PedidosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PedidosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PedidosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PedidosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> cliente = const Value.absent(),
            Value<String> itens = const Value.absent(),
            Value<String?> observacao = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
          }) =>
              PedidosCompanion(
            id: id,
            cliente: cliente,
            itens: itens,
            observacao: observacao,
            status: status,
            criadoEm: criadoEm,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String cliente,
            required String itens,
            Value<String?> observacao = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> criadoEm = const Value.absent(),
          }) =>
              PedidosCompanion.insert(
            id: id,
            cliente: cliente,
            itens: itens,
            observacao: observacao,
            status: status,
            criadoEm: criadoEm,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PedidosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PedidosTable,
    Pedido,
    $$PedidosTableFilterComposer,
    $$PedidosTableOrderingComposer,
    $$PedidosTableAnnotationComposer,
    $$PedidosTableCreateCompanionBuilder,
    $$PedidosTableUpdateCompanionBuilder,
    (Pedido, BaseReferences<_$AppDatabase, $PedidosTable, Pedido>),
    Pedido,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PedidosTableTableManager get pedidos =>
      $$PedidosTableTableManager(_db, _db.pedidos);
}
