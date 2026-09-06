import 'package:flutter/material.dart';
import 'package:postgrest/postgrest.dart';

import '../data/admin_repository.dart';
import '../l10n/generated/app_localizations.dart';
import '../theme/app_theme.dart';
import 'confirm_dialog.dart';

class AddRestaurantSheet extends StatefulWidget {
  const AddRestaurantSheet({super.key});

  @override
  State<AddRestaurantSheet> createState() => _AddRestaurantSheetState();
}

class _AddRestaurantSheetState extends State<AddRestaurantSheet> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _repo = AdminRepository();
  bool _loading = false;
  bool _obscure = true;
  String? _error;
  int _months = 12;

  static const _durations = <int>[1, 3, 6, 12, 24];

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.createRestaurantQuestion,
      message: l10n.createRestaurantMessage,
      confirmLabel: l10n.create,
      icon: Icons.storefront_rounded,
    );
    if (!confirmed || !mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final code = await _repo.createRestaurant(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
        durationMonths: _months,
      );
      if (!mounted) return;
      Navigator.pop(context, code ?? '');
    } catch (e) {
      if (mounted) {
        final msg = e is PostgrestException && e.message.isNotEmpty ? e.message : l10n.somethingWentWrong;
        setState(() {
          _error = msg;
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
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
                    child: const Icon(Icons.storefront_rounded, size: 22, color: kAccent),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.addRestaurantSheetTitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: cs.onSurface)),
                        const SizedBox(height: 2),
                        Text(
                          l10n.addRestaurantSheetSubtitle,
                          style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined, size: 20),
                  labelText: l10n.restaurantEmail,
                ),
                validator: (v) => v == null || !v.contains('@') ? l10n.login_invalidEmail : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _passCtrl,
                obscureText: _obscure,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline, size: 20),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility, size: 20),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                  labelText: l10n.login_passwordLabel,
                ),
                validator: (v) => v == null || v.length < 6 ? l10n.passwordTooShortMin6 : null,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.timer_outlined, size: 16, color: kAccent),
                  const SizedBox(width: 8),
                  Text(l10n.activationDuration, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: cs.onSurface)),
                  const Spacer(),
                  Text(
                    l10n.mintsPromoCode,
                    style: TextStyle(fontSize: 11.5, color: cs.onSurfaceVariant),
                  ),
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
                        l10n.durationMonths(m),
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
                      child: Text(l10n.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _loading ? null : _submit,
                      child: _loading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : Text(l10n.create),
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
