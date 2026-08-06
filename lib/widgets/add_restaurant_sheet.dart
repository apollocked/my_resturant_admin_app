import 'package:flutter/material.dart';
import 'package:postgrest/postgrest.dart';

import '../data/admin_repository.dart';

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

  static const _durationOptions = <int>[0, 1, 3, 6, 12, 24];

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
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
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Add restaurant', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: cs.onSurface)),
              const SizedBox(height: 4),
              Text(
                'Creates the restaurant account directly. A promo code is minted and claimed when an activation duration is chosen.',
                style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined, size: 20),
                  labelText: 'Restaurant email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null,
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
                  labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                validator: (v) => v == null || v.length < 6 ? 'Password too short (min 6)' : null,
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<int>(
                initialValue: _months,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.timer_outlined, size: 20),
                  labelText: 'Activation duration',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                ),
                items: _durationOptions
                    .map((m) => DropdownMenuItem(
                          value: m,
                          child: Text(m == 0 ? 'No activation' : '$m month${m == 1 ? '' : 's'}'),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _months = v ?? 0),
              ),
              if (_error != null) ...[
                const SizedBox(height: 14),
                Text(_error!, style: TextStyle(color: cs.error, fontSize: 13)),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _loading ? null : () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _loading ? null : _submit,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: _loading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                          : const Text('Create', style: TextStyle(fontWeight: FontWeight.w700)),
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
