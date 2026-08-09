import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/supabase_config.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'theme/app_theme.dart';
import 'widgets/confirm_dialog.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.anonKey,
  );
  runApp(const MyRestAdminApp());
}

class MyRestAdminApp extends StatelessWidget {
  const MyRestAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Rest Admin',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      home: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;
          final exit = await showConfirmDialog(
            context,
            title: 'Exit app?',
            message: 'Are you sure you want to close My Rest Admin?',
            confirmLabel: 'Exit',
            icon: Icons.exit_to_app_rounded,
            destructive: true,
          );
          if (exit) SystemNavigator.pop();
        },
        child: const AuthGate(),
      ),
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final StreamSubscription<AuthState> _sub;

  @override
  void initState() {
    super.initState();
    _sub = Supabase.instance.client.auth.onAuthStateChange.listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    return session == null ? const LoginPage() : const HomePage();
  }
}
