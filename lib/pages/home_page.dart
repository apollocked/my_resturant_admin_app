import 'package:flutter/material.dart';

import '../data/admin_repository.dart';
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
    if (!_checked) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!_authorized) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.gpp_bad_outlined, size: 64, color: Colors.orange),
              const SizedBox(height: 16),
              const Text('Access denied', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('Only the platform admin can use this app.'),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: () => _repo.signOut(),
                icon: const Icon(Icons.logout),
                label: const Text('Sign out'),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rest Admin'),
        actions: [
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: () => _repo.signOut(),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: const [RestaurantsPage(), PromoCodesPage()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront),
            label: 'Restaurants',
          ),
          NavigationDestination(
            icon: Icon(Icons.vpn_key_outlined),
            selectedIcon: Icon(Icons.vpn_key),
            label: 'Promo Codes',
          ),
        ],
      ),
    );
  }
}
