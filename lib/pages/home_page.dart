import 'package:flutter/material.dart';

import '../data/admin_repository.dart';
import '../theme/app_theme.dart';
import 'promo_codes_page.dart';
import 'restaurants_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repo = AdminRepository();
  int _index = 0;
  bool _checked = false;
  bool _authorized = true;

  @override
  void initState() {
    super.initState();
    _verify();
  }

  Future<void> _verify() async {
    final ok = await _repo.isAdmin();
    if (mounted) {
      setState(() {
        _authorized = ok;
        _checked = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    if (!_checked) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!_authorized) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: kWarning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(Icons.gpp_bad_outlined, size: 52, color: kWarning),
                ),
                const SizedBox(height: 24),
                const Text('Access denied', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(
                  'Only the platform admin can use this app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => _repo.signOut(),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Sign out'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [kAccent, Color(0xFFB15CFF)],
                ),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Icon(Icons.storefront, size: 17, color: Colors.white),
            ),
            const SizedBox(width: 10),
            const Text('My Rest Admin'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => _repo.signOut(),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: const [RestaurantsPage(), PromoCodesPage()],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: dark ? const Color(0xFF15161C) : Colors.white,
          border: Border(
            top: BorderSide(
              color: (dark ? Colors.white : const Color(0xFF111827)).withValues(alpha: dark ? 0.10 : 0.07),
            ),
          ),
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.storefront_outlined),
                selectedIcon: Icon(Icons.storefront_rounded),
                label: 'Restaurants',
              ),
              NavigationDestination(
                icon: Icon(Icons.vpn_key_outlined),
                selectedIcon: Icon(Icons.vpn_key_rounded),
                label: 'Promo Codes',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
