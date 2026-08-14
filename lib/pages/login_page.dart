import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/theme/app_colors.dart';
import '../data/admin_repository.dart';
import '../theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _repo = AdminRepository();
  bool _loading = false;
  bool _obscure = true;
  String? _error;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await Supabase.instance.client.auth.signInWithPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text,
      );
      final admin = await _repo.isAdmin();
      if (!admin) {
        await _repo.signOut();
        if (mounted) {
          setState(() => _error = 'This account is not authorized as platform admin.');
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _error = e is AuthException && e.message.isNotEmpty
            ? e.message
            : 'Sign in failed. Check your credentials.');
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: dark
                ? const [Color(0xFF141019), Color(0xFF0D0E12)]
                : const [Color(0xFFEFEBFF), Color(0xFFF5F5FA)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -90,
              right: -70,
              child: _glow(dark ? kAccent.withValues(alpha: 0.28) : kAccent.withValues(alpha: 0.18), 240),
            ),
            Positioned(
              bottom: -110,
              left: -80,
              child: _glow(dark ? const Color(0xFFFFA17A).withValues(alpha: 0.20) : const Color(0xFFFFA17A).withValues(alpha: 0.14), 260),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(24, 30, 24, 26),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: dark ? 0.06 : 0.62),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: dark ? 0.12 : 0.5),
                            ),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 72,
                                  height: 72,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [kAccent, Color(0xFFFF8A5C)],
                                    ),
                                    borderRadius: BorderRadius.circular(22),
                                    boxShadow: [
                                      BoxShadow(
                                        color: kAccent.withValues(alpha: 0.4),
                                        blurRadius: 22,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(Icons.storefront, size: 36, color: Colors.white),
                                ),
                                const SizedBox(height: 20),
                Text(
                  'My Rest Admin',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    color: dark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Platform control center',
                  style: TextStyle(
                    fontSize: 14,
                    color: (dark ? Colors.white : AppColors.textPrimary).withValues(alpha: 0.6),
                  ),
                ),
                                const SizedBox(height: 28),
                                TextFormField(
                                  controller: _emailCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.alternate_email_rounded, size: 20),
                                    labelText: 'Email',
                                  ),
                                  validator: (v) => v == null || !v.contains('@') ? 'Enter a valid email' : null,
                                ),
                                const SizedBox(height: 14),
                                TextFormField(
                                  controller: _passCtrl,
                                  obscureText: _obscure,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
                                    suffixIcon: IconButton(
                                      icon: Icon(_obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded, size: 20),
                                      onPressed: () => setState(() => _obscure = !_obscure),
                                    ),
                                    labelText: 'Password',
                                  ),
                                  validator: (v) => v == null || v.length < 6 ? 'Password too short' : null,
                                  onFieldSubmitted: (_) => _login(),
                                ),
                                if (_error != null) ...[
                                  const SizedBox(height: 14),
                                  Text(
                                    _error!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: kDanger, fontSize: 13),
                                  ),
                                ],
                                const SizedBox(height: 22),
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: FilledButton(
                                    onPressed: _loading ? null : _login,
                                    child: _loading
                                        ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5))
                                        : const Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.login_rounded, size: 20),
                                              SizedBox(width: 8),
                                              Text('Sign in'),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glow(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}
