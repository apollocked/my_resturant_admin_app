import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:postgrest/postgrest.dart';

import '../data/admin_repository.dart';
import '../theme/app_theme.dart';

class AddPromoCodeSheet extends StatefulWidget {
  const AddPromoCodeSheet({super.key});

  @override
  State<AddPromoCodeSheet> createState() => _AddPromoCodeSheetState();
}

class _AddPromoCodeSheetState extends State<AddPromoCodeSheet> {
  final _codeCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _repo = AdminRepository();
  bool _loading = false;
  String? _error;
  int _months = 12;

  static const _durations = <int>[1, 3, 6, 12, 24];
  static const _durationLabels = <int, String>{
    1: '1 mo',
    3: '3 mo',
    6: '6 mo',
    12: '12 mo',
    24: '24 mo',
  };

  @override
  void dispose() {
    _codeCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final code = await _repo.createPromoCode(
        code: _codeCtrl.text.trim().isEmpty ? null : _codeCtrl.text.trim(),
        durationMonths: _months,
      );
      if (!mounted) return;
      Navigator.pop(context, code);
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e is PostgrestException && e.message.isNotEmpty ? e.message : 'Something went wrong.';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 160),
                decoration: BoxDecoration(
                  color: cs.outlineVariant.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: kAccent.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(Icons.vpn_key_rounded, size: 22, color: kAccent),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add promo code', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: cs.onSurface)),
                        const SizedBox(height: 2),
                        Text(
                          'Mints a code that restaurants can claim for activation.',
                          style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _codeCtrl,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9]')),
                  LengthLimitingTextInputFormatter(32),
                ],
                onChanged: (_) => setState(() {}),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.dialpad_rounded, size: 20),
                  labelText: 'Custom code (optional)',
                  suffixIcon: _codeCtrl.text.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.close_rounded, size: 18),
                          onPressed: () => _codeCtrl.clear(),
                        ),
                ),
                validator: (v) {
                  final value = v?.trim() ?? '';
                  if (value.isEmpty) return null;
                  if (value.length < 4) return 'Min 4 characters';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              Text(
                'Leave empty to auto-generate a random code.',
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 16, color: kAccent),
                  const SizedBox(width: 8),
                  Text('Activation duration', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: cs.onSurface)),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _durations.map((m) {
                  final selected = _months == m;
                  return InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => setState(() => _months = m),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: selected ? kAccent : (dark ? Colors.white : const Color(0xFF111827)).withValues(alpha: dark ? 0.05 : 0.04),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: selected ? kAccent : (dark ? Colors.white : const Color(0xFF111827)).withValues(alpha: dark ? 0.10 : 0.07)),
                      ),
                      child: Text(
                        _durationLabels[m]!,
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: selected ? Colors.white : cs.onSurface,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              if (_error != null) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: kDanger.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline_rounded, size: 18, color: kDanger),
                      const SizedBox(width: 8),
                      Expanded(child: Text(_error!, style: const TextStyle(color: kDanger, fontSize: 13))),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _loading ? null : () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _loading ? null : _submit,
                      child: _loading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Mint code'),
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
