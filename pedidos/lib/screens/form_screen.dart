import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pedido_provider.dart';
import '../main.dart';

class FormScreen extends ConsumerStatefulWidget {
  const FormScreen({super.key});

  @override
  ConsumerState<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends ConsumerState<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clienteController = TextEditingController();
  final _itensController = TextEditingController();
  final _obsController = TextEditingController();
  bool _salvando = false;

  @override
  void dispose() {
    _clienteController.dispose();
    _itensController.dispose();
    _obsController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _salvando = true);
    await ref.read(pedidoNotifierProvider.notifier).criar(
          cliente: _clienteController.text.trim(),
          itens: _itensController.text.trim(),
          observacao: _obsController.text.trim().isEmpty
              ? null
              : _obsController.text.trim(),
        );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: kBgColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          _TopBar(onBack: () => Navigator.pop(context)),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 28, 20, keyboardHeight + 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // ── CLIENTE ──────────────────────────────────────
                    _SectionLabel(text: 'CLIENTE'),
                    const SizedBox(height: 10),
                    _PlainField(
                      controller: _clienteController,
                      hint: 'Nome do cliente ou número da mesa',
                      maxLines: 1,
                      capitalization: TextCapitalization.words,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Informe o cliente'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    // ── ITENS ─────────────────────────────────────────
                    _SectionLabel(text: 'ITENS DO PEDIDO'),
                    const SizedBox(height: 10),
                    _PlainField(
                      controller: _itensController,
                      hint: 'Descreva os pratos e quantidades...',
                      maxLines: 4,
                      capitalization: TextCapitalization.sentences,
                      validator: (v) => (v == null || v.trim().isEmpty)
                          ? 'Informe os itens'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    // ── OBSERVAÇÃO ────────────────────────────────────
                    _SectionLabelOptional(),
                    const SizedBox(height: 10),
                    _PlainField(
                      controller: _obsController,
                      hint: 'Alergias, preferências ou instruções especiais...',
                      maxLines: 3,
                      capitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 32),

                    // ── DIVIDER COM ÍCONE ─────────────────────────────
                    _IconDivider(),
                    const SizedBox(height: 24),

                    // ── INFO CARD ─────────────────────────────────────
                    _InfoCard(),
                  ],
                ),
              ),
            ),
          ),
          // ── BOTÃO FIXO NO RODAPÉ ──────────────────────────────────
          _BottomButton(salvando: _salvando, onPressed: _salvar),
        ],
      ),
    );
  }
}

// ─── Top Bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(20, top + 14, 20, 22),
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
          // Back button
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.arrow_back_ios_new, size: 18, color: kTextPrimary),
            ),
          ),
          const SizedBox(width: 16),
          // Title
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Novo Pedido',
                style: TextStyle(
                  color: kAccent,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Preencha os dados abaixo',
                style: TextStyle(color: kTextSecondary, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Section Labels ───────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: kTextSecondary,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _SectionLabelOptional extends StatelessWidget {
  const _SectionLabelOptional();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'OBSERVAÇÃO',
          style: TextStyle(
            color: kTextSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '(OPCIONAL)',
          style: TextStyle(
            color: kAccent,
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}

// ─── Plain Field ──────────────────────────────────────────────────────────────

class _PlainField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? Function(String?)? validator;

  const _PlainField({
    required this.controller,
    required this.hint,
    required this.maxLines,
    required this.capitalization,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      textCapitalization: capitalization,
      validator: validator,
      style: const TextStyle(color: kTextPrimary, fontSize: 15),
      cursorColor: kAccent,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF555555), fontSize: 15),
        filled: true,
        fillColor: const Color(0xFF1A1A1A),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: kAccent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        errorStyle: const TextStyle(color: Colors.redAccent, fontSize: 12),
      ),
    );
  }
}

// ─── Icon Divider ─────────────────────────────────────────────────────────────

class _IconDivider extends StatelessWidget {
  const _IconDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: kBorder, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Icon(Icons.restaurant, color: kTextSecondary, size: 18),
        ),
        Expanded(child: Divider(color: kBorder, thickness: 1)),
      ],
    );
  }
}

// ─── Info Card ────────────────────────────────────────────────────────────────

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: kAccent, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REGRAS DA COZINHA',
            style: TextStyle(
              color: kAccent,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Pedidos enviados entram imediatamente na fila de produção. Verifique os itens antes de confirmar.',
            style: TextStyle(
              color: kTextSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Button ────────────────────────────────────────────────────────────

class _BottomButton extends StatelessWidget {
  final bool salvando;
  final VoidCallback onPressed;
  const _BottomButton({required this.salvando, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: kBgColor,
          border: Border(top: BorderSide(color: kBorder, width: 1)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
        child: GestureDetector(
          onTap: salvando ? null : onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: 56,
            decoration: BoxDecoration(
              color: salvando ? kAccent.withValues(alpha: 0.5) : kAccent,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: salvando
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.black,
                    ),
                  )
                : const Text(
                    'Criar Pedido',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      letterSpacing: -0.2,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
