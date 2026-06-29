import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../models/pedido.dart';
import '../providers/pedido_provider.dart';
import 'form_screen.dart';
import 'detalhe_screen.dart';
import '../main.dart';

const _kGreen = Color(0xFF4CAF7D);

const _kBlue = Color(0xFF4C9EFF);
const _kOrange = Color(0xFFFFAA33);

// ─── Shell com navegação por abas ────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _abaAtual = 0;

  static const _abas = [
    _AbaItem(icone: Icons.receipt_long_outlined, iconeAtivo: Icons.receipt_long, label: 'Pedidos'),
    _AbaItem(icone: Icons.history_outlined, iconeAtivo: Icons.history, label: 'Histórico'),
    _AbaItem(icone: Icons.bar_chart_outlined, iconeAtivo: Icons.bar_chart, label: 'Estatísticas'),
    _AbaItem(icone: Icons.settings_outlined, iconeAtivo: Icons.settings, label: 'Configurações'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: IndexedStack(
        index: _abaAtual,
        children: [
          _PedidosTab(onNovoTap: _abrirFormulario),
          const _HistoricoTab(),
          const _EstatisticasTab(),
          const _ConfiguracoesTab(),
        ],
      ),
      bottomNavigationBar: _BarraNavegacao(
        abaAtual: _abaAtual,
        abas: _abas,
        onTap: (i) => setState(() => _abaAtual = i),
      ),
      floatingActionButton: _abaAtual == 0
          ? FloatingActionButton(
              onPressed: _abrirFormulario,
              backgroundColor: kAccent,
              foregroundColor: Colors.black,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, size: 28),
            )
          : null,
    );
  }

  void _abrirFormulario() => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FormScreen()),
      );
}

// ─── Barra de Navegação ───────────────────────────────────────────────────────

class _AbaItem {
  final IconData icone;
  final IconData iconeAtivo;
  final String label;
  const _AbaItem({required this.icone, required this.iconeAtivo, required this.label});
}

class _BarraNavegacao extends StatelessWidget {
  final int abaAtual;
  final List<_AbaItem> abas;
  final ValueChanged<int> onTap;

  const _BarraNavegacao({
    required this.abaAtual,
    required this.abas,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(bottom: bottom),
      decoration: const BoxDecoration(
        color: kCardColor,
        border: Border(top: BorderSide(color: kBorder, width: 1)),
      ),
      child: Row(
        children: List.generate(abas.length, (i) {
          final aba = abas[i];
          final ativo = i == abaAtual;
          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: ativo ? kAccent.withValues(alpha: 0.15) : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        ativo ? aba.iconeAtivo : aba.icone,
                        color: ativo ? kAccent : kTextSecondary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      aba.label,
                      style: TextStyle(
                        color: ativo ? kAccent : kTextSecondary,
                        fontSize: 11,
                        fontWeight: ativo ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─── Aba: Pedidos ─────────────────────────────────────────────────────────────

class _PedidosTab extends ConsumerWidget {
  final VoidCallback onNovoTap;
  const _PedidosTab({required this.onNovoTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidosAsync = ref.watch(pedidosProvider);

    return pedidosAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: kAccent)),
      error: (e, _) => Center(child: Text('Erro: $e')),
      data: (pedidos) {
        final novos = pedidos.where((p) => p.status == 'novo').length;
        final emPreparo = pedidos.where((p) => p.status == 'emPreparo').length;
        final entregues = pedidos.where((p) => p.status == 'entregue').length;

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _AppHeader(
                total: pedidos.length,
                novos: novos,
                emPreparo: emPreparo,
                entregues: entregues,
              ),
            ),
            if (pedidos.isEmpty)
              const SliverFillRemaining(child: _EmptyState())
            else ...[
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 10),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Fila Ativa',
                        style: TextStyle(
                          color: kTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'Atualizado agora',
                        style: TextStyle(color: kTextSecondary, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 110),
                sliver: SliverList.separated(
                  itemCount: pedidos.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final pedido = pedidos[index];
                    final status = StatusPedido.values.byName(pedido.status);
                    return _PedidoCard(pedido: pedido, status: status);
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

// ─── Aba: Histórico ───────────────────────────────────────────────────────────

enum _FiltroPeriodo { hoje, semana, mes }

class _HistoricoTab extends ConsumerStatefulWidget {
  const _HistoricoTab();

  @override
  ConsumerState<_HistoricoTab> createState() => _HistoricoTabState();
}

class _HistoricoTabState extends ConsumerState<_HistoricoTab> {
  _FiltroPeriodo _filtro = _FiltroPeriodo.hoje;

  @override
  Widget build(BuildContext context) {
    final pedidosAsync = ref.watch(pedidosProvider);
    final top = MediaQuery.of(context).padding.top;

    return pedidosAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: kAccent)),
      error: (e, _) => Center(child: Text('Erro: $e')),
      data: (pedidos) {
        final entregues = pedidos
            .where((p) => p.status == 'entregue')
            .where((p) => _dentroDoFiltro(p.criadoEm))
            .toList()
          ..sort((a, b) => b.criadoEm.compareTo(a.criadoEm));

        final totalValor = entregues.fold(0.0, (acc, p) => acc + _extrairTotal(p.itens));
        final grupos = _agruparPorData(entregues);

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _HistoricoHeader(
                top: top,
                totalValor: totalValor,
                totalPedidos: entregues.length,
                filtro: _filtro,
                onFiltroChanged: (f) => setState(() => _filtro = f),
              ),
            ),
            if (entregues.isEmpty)
              const SliverFillRemaining(child: _HistoricoEmptyState())
            else ...[
              for (final grupo in grupos) ...[
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 10),
                  sliver: SliverToBoxAdapter(
                    child: _GrupoLabel(label: grupo.label, count: grupo.pedidos.length),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.separated(
                    itemCount: grupo.pedidos.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (_, i) => _HistoricoCard(pedido: grupo.pedidos[i]),
                  ),
                ),
              ],
              const SliverPadding(padding: EdgeInsets.only(bottom: 110)),
            ],
          ],
        );
      },
    );
  }

  bool _dentroDoFiltro(DateTime dt) {
    final agora = DateTime.now();
    switch (_filtro) {
      case _FiltroPeriodo.hoje:
        return dt.year == agora.year && dt.month == agora.month && dt.day == agora.day;
      case _FiltroPeriodo.semana:
        return agora.difference(dt).inDays < 7;
      case _FiltroPeriodo.mes:
        return dt.year == agora.year && dt.month == agora.month;
    }
  }

  List<_GrupoData> _agruparPorData(List<Pedido> pedidos) {
    final Map<String, List<Pedido>> mapa = {};
    for (final p in pedidos) {
      final chave = _labelData(p.criadoEm);
      mapa.putIfAbsent(chave, () => []).add(p);
    }
    return mapa.entries.map((e) => _GrupoData(label: e.key, pedidos: e.value)).toList();
  }

  String _labelData(DateTime dt) {
    final agora = DateTime.now();
    final hoje = DateTime(agora.year, agora.month, agora.day);
    final ontem = hoje.subtract(const Duration(days: 1));
    final dia = DateTime(dt.year, dt.month, dt.day);
    const meses = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];
    if (dia == hoje) return 'Hoje, ${dt.day} de ${meses[dt.month - 1]}';
    if (dia == ontem) return 'Ontem, ${dt.day} de ${meses[dt.month - 1]}';
    return '${dt.day} de ${meses[dt.month - 1]}';
  }

  static double _extrairTotal(String itens) {
    final regex = RegExp(r'R\$\s*([\d.,]+)', caseSensitive: false);
    double soma = 0.0;
    for (final m in regex.allMatches(itens)) {
      final val = m.group(1)!.replaceAll('.', '').replaceAll(',', '.');
      soma += double.tryParse(val) ?? 0.0;
    }
    return soma;
  }
}

class _GrupoData {
  final String label;
  final List<Pedido> pedidos;
  const _GrupoData({required this.label, required this.pedidos});
}

// ─── Header do Histórico ──────────────────────────────────────────────────────

class _HistoricoHeader extends StatelessWidget {
  final double top;
  final double totalValor;
  final int totalPedidos;
  final _FiltroPeriodo filtro;
  final ValueChanged<_FiltroPeriodo> onFiltroChanged;

  const _HistoricoHeader({
    required this.top,
    required this.totalValor,
    required this.totalPedidos,
    required this.filtro,
    required this.onFiltroChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, top + 18, 20, 20),
      decoration: const BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título
          const Text(
            'Histórico',
            style: TextStyle(
              color: kTextPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 16),
          // Filtros
          Row(
            children: [
              _FiltroChip(
                label: 'HOJE',
                ativo: filtro == _FiltroPeriodo.hoje,
                onTap: () => onFiltroChanged(_FiltroPeriodo.hoje),
              ),
              const SizedBox(width: 8),
              _FiltroChip(
                label: 'SEMANA',
                ativo: filtro == _FiltroPeriodo.semana,
                onTap: () => onFiltroChanged(_FiltroPeriodo.semana),
              ),
              const SizedBox(width: 8),
              _FiltroChip(
                label: 'MÊS',
                ativo: filtro == _FiltroPeriodo.mes,
                onTap: () => onFiltroChanged(_FiltroPeriodo.mes),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Cards de resumo
          Row(
            children: [
              Expanded(
                child: _ResumoCard(
                  label: 'TOTAL VENDAS',
                  valor: 'R\$ ${totalValor.toStringAsFixed(2).replaceAll('.', ',')}',
                  grande: true,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ResumoCard(
                  label: 'PEDIDOS',
                  valor: '$totalPedidos',
                  grande: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Chip de Filtro ───────────────────────────────────────────────────────────

class _FiltroChip extends StatelessWidget {
  final String label;
  final bool ativo;
  final VoidCallback onTap;

  const _FiltroChip({required this.label, required this.ativo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: ativo ? kAccent : kBgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ativo ? kAccent : kBorder),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: ativo ? Colors.black : kTextSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

// ─── Card de Resumo ───────────────────────────────────────────────────────────

class _ResumoCard extends StatelessWidget {
  final String label;
  final String valor;
  final bool grande;

  const _ResumoCard({required this.label, required this.valor, required this.grande});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kBgColor,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: kAccent, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: kTextSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            valor,
            style: TextStyle(
              color: kAccent,
              fontSize: grande ? 22 : 28,
              fontWeight: FontWeight.bold,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Label de Grupo (data + contagem) ────────────────────────────────────────

class _GrupoLabel extends StatelessWidget {
  final String label;
  final int count;
  const _GrupoLabel({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: kTextPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$count PEDIDO${count == 1 ? '' : 'S'}',
          style: const TextStyle(
            color: kTextSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

// ─── Card de Histórico ────────────────────────────────────────────────────────

class _HistoricoCard extends StatelessWidget {
  final Pedido pedido;
  const _HistoricoCard({required this.pedido});

  static const _icones = [
    Icons.restaurant_menu,
    Icons.local_pizza_outlined,
    Icons.lunch_dining_outlined,
    Icons.ramen_dining_outlined,
    Icons.set_meal_outlined,
    Icons.kebab_dining_outlined,
  ];

  IconData get _icone => _icones[pedido.id % _icones.length];

  double get _total => _HistoricoTabState._extrairTotal(pedido.itens);

  String get _horario {
    final h = pedido.criadoEm.hour.toString().padLeft(2, '0');
    final m = pedido.criadoEm.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kCardColor,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: kAccent.withValues(alpha: 0.06),
        highlightColor: kAccent.withValues(alpha: 0.03),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetalheScreen(pedido: pedido)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: kAccent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_icone, color: kAccent, size: 22),
              ),
              const SizedBox(width: 14),
              // Nome + horário
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pedido.cliente,
                      style: const TextStyle(
                        color: kTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Entregue às $_horario',
                      style: const TextStyle(color: kTextSecondary, fontSize: 13),
                    ),
                  ],
                ),
              ),
              // Valor + status
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _total > 0
                        ? 'R\$ ${_total.toStringAsFixed(2).replaceAll('.', ',')}'
                        : '—',
                    style: const TextStyle(
                      color: kAccent,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'CONCLUÍDO',
                    style: TextStyle(
                      color: _kGreen,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Empty State do Histórico ─────────────────────────────────────────────────

class _HistoricoEmptyState extends StatelessWidget {
  const _HistoricoEmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: kAccent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: kAccent.withValues(alpha: 0.3)),
            ),
            child: const Icon(Icons.history, size: 40, color: kAccent),
          ),
          const SizedBox(height: 20),
          const Text(
            'Nenhum pedido encontrado',
            style: TextStyle(color: kTextPrimary, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Os pedidos concluídos aparecem aqui',
            style: TextStyle(color: kTextSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

// ─── Aba: Estatísticas ────────────────────────────────────────────────────────

class _EstatisticasTab extends ConsumerWidget {
  const _EstatisticasTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pedidosAsync = ref.watch(pedidosProvider);
    final top = MediaQuery.of(context).padding.top;

    return pedidosAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: kAccent)),
      error: (e, _) => Center(child: Text('Erro: $e')),
      data: (pedidos) {
        final total = pedidos.length;
        final novos = pedidos.where((p) => p.status == 'novo').length;
        final emPreparo = pedidos.where((p) => p.status == 'emPreparo').length;
        final entregues = pedidos.where((p) => p.status == 'entregue').length;
        final taxaEntrega = total == 0 ? 0.0 : entregues / total;

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, top + 18, 20, 22),
                decoration: const BoxDecoration(
                  color: kCardColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: const Text(
                  'Estatísticas',
                  style: TextStyle(color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _StatRow(label: 'Total de pedidos', valor: '$total', cor: kAccent),
                  const SizedBox(height: 12),
                  _StatRow(label: 'Novos', valor: '$novos', cor: _kBlue),
                  const SizedBox(height: 12),
                  _StatRow(label: 'Em preparo', valor: '$emPreparo', cor: _kOrange),
                  const SizedBox(height: 12),
                  _StatRow(label: 'Entregues', valor: '$entregues', cor: kAccent),
                  const SizedBox(height: 24),
                  _TaxaEntrega(taxa: taxaEntrega),
                ]),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String valor;
  final Color cor;

  const _StatRow({required this.label, required this.valor, required this.cor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: cor, width: 3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: kTextSecondary, fontSize: 14)),
          Text(valor, style: TextStyle(color: cor, fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _TaxaEntrega extends StatelessWidget {
  final double taxa;
  const _TaxaEntrega({required this.taxa});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Taxa de entrega', style: TextStyle(color: kTextSecondary, fontSize: 14)),
              Text(
                '${(taxa * 100).toStringAsFixed(0)}%',
                style: const TextStyle(color: kAccent, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: taxa,
              backgroundColor: kBorder,
              color: kAccent,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Aba: Configurações ───────────────────────────────────────────────────────

class _ConfiguracoesTab extends StatelessWidget {
  const _ConfiguracoesTab();

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, top + 18, 20, 22),
            decoration: const BoxDecoration(
              color: kCardColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: const Text(
              'Configurações',
              style: TextStyle(color: kTextPrimary, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _ConfigItem(icone: Icons.store_outlined, titulo: 'Nome da unidade', subtitulo: 'Unidade Centro'),
              const SizedBox(height: 12),
              _ConfigItem(icone: Icons.notifications_outlined, titulo: 'Notificações', subtitulo: 'Ativadas'),
              const SizedBox(height: 12),
              _ConfigItem(icone: Icons.color_lens_outlined, titulo: 'Tema', subtitulo: 'Escuro'),
              const SizedBox(height: 12),
              _ConfigItem(icone: Icons.info_outline, titulo: 'Versão do app', subtitulo: '1.0.0'),
            ]),
          ),
        ),
      ],
    );
  }
}

class _ConfigItem extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String subtitulo;

  const _ConfigItem({required this.icone, required this.titulo, required this.subtitulo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: kCardColor, borderRadius: BorderRadius.circular(14)),
      child: Row(
        children: [
          Icon(icone, color: kAccent, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: const TextStyle(color: kTextPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
                Text(subtitulo, style: const TextStyle(color: kTextSecondary, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: kTextSecondary, size: 18),
        ],
      ),
    );
  }
}

// ─── App Header ─────────────────────────────────────────────────────────────

class _AppHeader extends StatelessWidget {
  final int total;
  final int novos;
  final int emPreparo;
  final int entregues;

  const _AppHeader({
    required this.total,
    required this.novos,
    required this.emPreparo,
    required this.entregues,
  });

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(20, top + 18, 20, 22),
      decoration: const BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title row
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gerenciador de Pedidos',
                      style: TextStyle(
                        color: kTextPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.3,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Unidade Centro · Ativo agora',
                      style: TextStyle(color: kTextSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Total badge
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: kAccent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$total',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Stat cards row
          Row(
            children: [
              _StatCard(label: 'NOVOS', count: novos, color: _kBlue),
              const SizedBox(width: 10),
              _StatCard(label: 'PREPARO', count: emPreparo, color: _kOrange),
              const SizedBox(width: 10),
              _StatCard(label: 'ENTREGUES', count: entregues, color: kAccent),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Stat Card ───────────────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _StatCard({
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        decoration: BoxDecoration(
          color: kBgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border(left: BorderSide(color: color, width: 3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: kTextSecondary,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '$count',
              style: TextStyle(
                color: color,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Pedido Card ─────────────────────────────────────────────────────────────

class _PedidoCard extends StatelessWidget {
  final Pedido pedido;
  final StatusPedido status;

  const _PedidoCard({required this.pedido, required this.status});

  Color get _cor {
    switch (status) {
      case StatusPedido.novo:
        return _kBlue;
      case StatusPedido.emPreparo:
        return _kOrange;
      case StatusPedido.entregue:
        return kAccent;
    }
  }

  IconData get _icone {
    switch (status) {
      case StatusPedido.novo:
        return Icons.notifications_active_outlined;
      case StatusPedido.emPreparo:
        return Icons.storefront_outlined;
      case StatusPedido.entregue:
        return Icons.check_circle_outline;
    }
  }

  String get _badgeLabel {
    switch (status) {
      case StatusPedido.novo:
        return 'NOVO';
      case StatusPedido.emPreparo:
        return 'EM PREPARO';
      case StatusPedido.entregue:
        return 'ENTREGUE';
    }
  }

  String get _subLabel {
    if (status == StatusPedido.entregue) return 'Concluído';
    final hora = pedido.criadoEm;
    return '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isEntregue = status == StatusPedido.entregue;

    return Material(
      color: kCardColor,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: _cor.withValues(alpha: 0.08),
        highlightColor: _cor.withValues(alpha: 0.04),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetalheScreen(pedido: pedido)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
              child: Row(
                children: [
                  // Avatar
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: _cor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(_icone, color: _cor, size: 22),
                  ),
                  const SizedBox(width: 12),
                  // Nome + pedido info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pedido.cliente,
                          style: TextStyle(
                            color: isEntregue ? kTextSecondary : kTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Pedido #${pedido.id.toString().padLeft(4, '0')} · ${_criadoLabel(pedido.criadoEm)}',
                          style: const TextStyle(
                            color: kTextSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Badge + sub-label
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _cor.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _badgeLabel,
                          style: TextStyle(
                            color: _cor,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _subLabel,
                        style: TextStyle(
                          color: isEntregue ? kTextSecondary : _cor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Divider + itens preview
            Divider(height: 1, color: kBorder),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      pedido.itens,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isEntregue ? const Color(0xFF555555) : kTextSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right, color: kTextSecondary, size: 18),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _criadoLabel(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

// ─── Empty State ─────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: kAccent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: kAccent.withValues(alpha: 0.3)),
            ),
            child: const Icon(Icons.receipt_long_outlined, size: 40, color: kAccent),
          ),
          const SizedBox(height: 20),
          const Text(
            'Nenhum pedido ainda',
            style: TextStyle(
              color: kTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Toque em + para criar o primeiro',
            style: TextStyle(color: kTextSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
