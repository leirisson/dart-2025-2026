import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../models/pedido.dart';
import '../providers/pedido_provider.dart';
import '../main.dart';

const _kBlue = Color(0xFF4C9EFF);
const _kOrange = Color(0xFFFFAA33);

// ─── Helpers globais ─────────────────────────────────────────────────────────

Color _corStatus(StatusPedido s) {
  switch (s) {
    case StatusPedido.novo:      return _kBlue;
    case StatusPedido.emPreparo: return _kOrange;
    case StatusPedido.entregue:  return kAccent;
  }
}

StatusPedido? _proximo(StatusPedido s) {
  switch (s) {
    case StatusPedido.novo:      return StatusPedido.emPreparo;
    case StatusPedido.emPreparo: return StatusPedido.entregue;
    case StatusPedido.entregue:  return null;
  }
}

// Parseia uma linha de item no formato: "Nx Nome | detalhe | R$ 0,00"
// Qualquer campo ausente vira null.
class _ItemLinha {
  final String qtd;
  final String nome;
  final String? detalhe;
  final String? preco;

  _ItemLinha({
    required this.qtd,
    required this.nome,
    this.detalhe,
    this.preco,
  });

  factory _ItemLinha.parse(String linha) {
    // Divide por "|"
    final partes = linha.split('|').map((p) => p.trim()).toList();
    // Extrai qtd e nome do primeiro campo
    final principal = partes.isNotEmpty ? partes[0] : linha;
    final match = RegExp(r'^(\d+)[xX]\s*(.+)$').firstMatch(principal.trim());
    final qtd = match?.group(1) ?? '1';
    final nome = match?.group(2)?.trim() ?? principal.trim();
    final detalhe = partes.length >= 2 ? partes[1] : null;
    final preco = partes.length >= 3 ? partes[2] : null;
    return _ItemLinha(qtd: qtd, nome: nome, detalhe: detalhe, preco: preco);
  }
}

// ─── Screen ──────────────────────────────────────────────────────────────────

class DetalheScreen extends ConsumerWidget {
  final Pedido pedido;
  const DetalheScreen({super.key, required this.pedido});

  Future<void> _confirmarExclusao(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: kCardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Excluir pedido?', style: TextStyle(color: kTextPrimary)),
        content: Text(
          'O pedido de "${pedido.cliente}" será removido permanentemente.',
          style: const TextStyle(color: kTextSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar', style: TextStyle(color: kTextSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir',
                style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await ref.read(pedidoNotifierProvider.notifier).deletar(pedido.id);
      if (context.mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = StatusPedido.values.byName(pedido.status);
    final proximoStatus = _proximo(status);
    final cor = _corStatus(status);

    return Scaffold(
      backgroundColor: kBgColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          _Header(
            pedido: pedido,
            status: status,
            cor: cor,
            onBack: () => Navigator.pop(context),
            onDelete: () => _confirmarExclusao(context, ref),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _StatusTimeline(statusAtual: status),
                  const SizedBox(height: 14),
                  _DetalheCard(pedido: pedido, cor: cor),
                ],
              ),
            ),
          ),
          _BotaoAcao(
            proximoStatus: proximoStatus,
            currentStatus: status,
            onPressed: proximoStatus == null
                ? null
                : () async {
                    await ref
                        .read(pedidoNotifierProvider.notifier)
                        .atualizarStatus(pedido, proximoStatus);
                    if (context.mounted) Navigator.pop(context);
                  },
          ),
        ],
      ),
    );
  }
}

// ─── Header ──────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  final Pedido pedido;
  final StatusPedido status;
  final Color cor;
  final VoidCallback onBack;
  final VoidCallback onDelete;

  const _Header({
    required this.pedido,
    required this.status,
    required this.cor,
    required this.onBack,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(16, top + 14, 16, 22),
      decoration: const BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Botão voltar
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18, color: kTextPrimary),
            ),
          ),
          // Título centralizado
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  pedido.cliente,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: kTextPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                  decoration: BoxDecoration(
                    color: cor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status.label.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Botão deletar
          GestureDetector(
            onTap: onDelete,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF4A1010),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.delete_outline, size: 20, color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Status Timeline ─────────────────────────────────────────────────────────

class _StatusTimeline extends StatelessWidget {
  final StatusPedido statusAtual;
  const _StatusTimeline({required this.statusAtual});

  @override
  Widget build(BuildContext context) {
    final etapas = StatusPedido.values;
    final indexAtual = etapas.indexOf(statusAtual);
    final cores = [_kBlue, _kOrange, kAccent];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(etapas.length * 2 - 1, (i) {
          // Linha conectora
          if (i.isOdd) {
            final passado = i ~/ 2 < indexAtual;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 2,
                  color: passado ? cores[i ~/ 2] : kBorder,
                ),
              ),
            );
          }

          final idx = i ~/ 2;
          final ativo = idx == indexAtual;
          final passado = idx < indexAtual;
          final cor = cores[idx];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Círculo
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ativo ? cor : Colors.transparent,
                  border: Border.all(
                    color: (ativo || passado) ? cor : kBorder,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: ativo
                      ? Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        )
                      : passado
                          ? Icon(Icons.check, color: cor, size: 14)
                          : null,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                etapas[idx].label,
                style: TextStyle(
                  color: (ativo || passado) ? cor : kTextSecondary,
                  fontSize: 12,
                  fontWeight: (ativo || passado) ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ─── Detalhe Card ────────────────────────────────────────────────────────────

class _DetalheCard extends StatelessWidget {
  final Pedido pedido;
  final Color cor;
  const _DetalheCard({required this.pedido, required this.cor});

  List<_ItemLinha> get _itens {
    return pedido.itens
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .map(_ItemLinha.parse)
        .toList();
  }

  String _formatarData(DateTime dt) {
    final d = dt.day.toString().padLeft(2, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$d/$m/${dt.year} $h:$min';
  }

  @override
  Widget build(BuildContext context) {
    final itens = _itens;
    final temObs = pedido.observacao != null && pedido.observacao!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Título seção itens ──────────────────────────────────
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 18, 18, 12),
            child: Text(
              'Itens do Pedido',
              style: TextStyle(
                color: kTextSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // ── Lista de itens ─────────────────────────────────────
          ...itens.map((item) => Padding(
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quantidade
                    SizedBox(
                      width: 32,
                      child: Text(
                        '${item.qtd}x',
                        style: TextStyle(
                          color: cor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Nome + detalhe
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.nome,
                            style: const TextStyle(
                              color: kTextPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (item.detalhe != null) ...[
                            const SizedBox(height: 3),
                            Text(
                              item.detalhe!,
                              style: const TextStyle(
                                color: kTextSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Preço
                    if (item.preco != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          item.preco!,
                          style: const TextStyle(
                            color: kTextPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              )),

          // ── Observação ─────────────────────────────────────────
          if (temObs) ...[
            Divider(height: 1, color: kBorder),
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 16, 18, 8),
              child: Text(
                'Observação',
                style: TextStyle(
                  color: kTextSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                decoration: BoxDecoration(
                  color: kBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _kOrange, width: 2),
                      ),
                      child: const Center(
                        child: Text(
                          'i',
                          style: TextStyle(
                            color: _kOrange,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '"${pedido.observacao}"',
                        style: const TextStyle(
                          color: kTextPrimary,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // ── Rodapé: Criado em + Cronômetro ────────────────────
          Divider(height: 1, color: kBorder),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Criado em
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Criado em',
                      style: TextStyle(color: kTextSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatarData(pedido.criadoEm),
                      style: const TextStyle(
                        color: kTextPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Cronômetro
                _Cronometro(criadoEm: pedido.criadoEm, cor: cor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Cronômetro ──────────────────────────────────────────────────────────────

class _Cronometro extends StatefulWidget {
  final DateTime criadoEm;
  final Color cor;
  const _Cronometro({required this.criadoEm, required this.cor});

  @override
  State<_Cronometro> createState() => _CronometroState();
}

class _CronometroState extends State<_Cronometro> {
  late Timer _timer;
  late Duration _elapsed;

  @override
  void initState() {
    super.initState();
    _elapsed = DateTime.now().difference(widget.criadoEm);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _elapsed = DateTime.now().difference(widget.criadoEm));
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = _elapsed.inHours;
    final m = (_elapsed.inMinutes % 60).toString().padLeft(2, '0');
    final s = (_elapsed.inSeconds % 60).toString().padLeft(2, '0');
    final label = h > 0 ? '$h:$m:$s' : '$m:$s';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'Tempo Decorrido',
          style: TextStyle(
            color: kTextSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: widget.cor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

// ─── Botão de Ação ───────────────────────────────────────────────────────────

class _BotaoAcao extends StatelessWidget {
  final StatusPedido currentStatus;
  final StatusPedido? proximoStatus;
  final VoidCallback? onPressed;

  const _BotaoAcao({
    required this.currentStatus,
    required this.proximoStatus,
    required this.onPressed,
  });

  String get _labelReal {
    if (proximoStatus == null) return 'PEDIDO CONCLUÍDO';
    switch (proximoStatus!) {
      case StatusPedido.emPreparo: return 'INICIAR PREPARO';
      case StatusPedido.entregue:  return 'MARCAR ENTREGUE';
      case StatusPedido.novo:      return 'PEDIDO CONCLUÍDO';
    }
  }

  Color get _cor {
    if (proximoStatus == null) return kAccent.withValues(alpha: 0.15);
    return _corStatus(proximoStatus!);
  }

  Color get _corTexto {
    if (proximoStatus == null) return kAccent;
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final concluido = proximoStatus == null;
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: kBgColor,
          border: Border(top: BorderSide(color: kBorder)),
        ),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: 58,
            decoration: BoxDecoration(
              color: _cor,
              borderRadius: BorderRadius.circular(16),
              border: concluido ? Border.all(color: kAccent.withValues(alpha: 0.3)) : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  concluido ? Icons.check_circle_outline : Icons.play_arrow,
                  color: _corTexto,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  _labelReal,
                  style: TextStyle(
                    color: _corTexto,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
