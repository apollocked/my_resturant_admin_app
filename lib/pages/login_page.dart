import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../core/theme/app_colors.dart';
import '../data/admin_repository.dart';
import '../l10n/generated/app_localizations.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import '../widgets/language_switcher.dart';

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
          setState(() => _error = AppLocalizations.of(context).login_unauthorized);
        }
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context);
        setState(() => _error = e is AuthException && e.message.isNotEmpty
            ? e.message
            : l10n.login_signInFailed);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
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
            Positioned(
              top: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Material(
                    color: Colors.transparent,
                    child: LanguageSwitcher(),
                  ),
                ),
              ),
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
                                const AppLogo(size: 110),
                                const SizedBox(height: 20),
                Text(
                  l10n.appTitle,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                    color: dark ? Colors.white : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.appSubtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: (dark ? Colors.white : AppColors.textPrimary).withValues(alpha: 0.6),
                  ),
                ),
                                const SizedBox(height: 28),
                                TextFormField(
                                  controller: _emailCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.alternate_email_rounded, size: 20),
                                    labelText: l10n.login_emailLabel,
                                  ),
                                  validator: (v) => v == null || !v.contains('@') ? l10n.login_invalidEmail : null,
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
                                    labelText: l10n.login_passwordLabel,
                                  ),
                                  validator: (v) => v == null || v.length < 6 ? l10n.login_passwordTooShort : null,
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
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(Icons.login_rounded, size: 20),
                                              const SizedBox(width: 8),
                                              Text(l10n.login_signIn),
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
