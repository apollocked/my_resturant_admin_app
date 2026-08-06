import 'package:flutter/material.dart';

import '../data/admin_repository.dart';
import '../models/restaurant_summary.dart';
import '../utils/format.dart';
import '../widgets/add_restaurant_sheet.dart';

class RestaurantsPage extends StatefulWidget {
  const RestaurantsPage({super.key});

  @override
  State<RestaurantsPage> createState() => _RestaurantsPageState();
}

class _RestaurantsPageState extends State<RestaurantsPage> {
  final _repo = AdminRepository();
  List<RestaurantSummary>? _restaurants;
  Object? _error;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final data = await _repo.listRestaurants();
      if (mounted) {
        setState(() {
          _restaurants = data;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e;
          _loading = false;
        });
      }
    }
  }

  Future<void> _openAdd() async {
    final code = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddRestaurantSheet(),
    );
    if (code == null) return;
    await _load();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          code.isEmpty
              ? 'Restaurant created.'
              : 'Restaurant created. Promo code: $code',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Widget body;
    if (_loading && _restaurants == null) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_error != null && _restaurants == null) {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            const Text('Failed to load restaurants'),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    } else if (_restaurants == null || _restaurants!.isEmpty) {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.storefront_outlined, size: 56, color: cs.outline),
            const SizedBox(height: 12),
            const Text('No restaurants yet'),
            const SizedBox(height: 4),
            Text('Tap + to add your first restaurant', style: TextStyle(color: cs.onSurfaceVariant)),
          ],
        ),
      );
    } else {
      body = RefreshIndicator(
        onRefresh: _load,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: _restaurants!.length,
          itemBuilder: (context, i) => _RestaurantCard(r: _restaurants![i]),
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAdd,
        icon: const Icon(Icons.add),
        label: const Text('Add restaurant'),
      ),
      body: body,
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final RestaurantSummary r;
  const _RestaurantCard({required this.r});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final activatedColor = r.activated ? Colors.green : Colors.orange;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: cs.primaryContainer,
                  child: Text(
                    avatarInitials(r.email),
                    style: TextStyle(fontWeight: FontWeight.w700, color: cs.onPrimaryContainer),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.email, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      Text('Joined ${formatDateShort(r.createdAt)}', style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                    ],
                  ),
                ),
                _chip(cs, activatedColor, r.activated ? 'Activated' : 'Not activated'),
              ],
            ),
            const SizedBox(height: 12),
            _promoBlock(cs),
            const SizedBox(height: 10),
            _staffBlock(cs),
            const SizedBox(height: 10),
            Row(
              children: [
                _stat(cs, Icons.restaurant_menu, r.recipesCount, 'recipes'),
                const SizedBox(width: 18),
                _stat(cs, Icons.receipt_long, r.ordersCount, 'orders'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _promoBlock(ColorScheme cs) {
    final code = r.promoCode;
    if (code == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Text('No promo code claimed', style: TextStyle(fontSize: 13)),
      );
    }
    final remaining = r.daysRemaining;
    final expColor = remaining == null
        ? cs.onSurfaceVariant
        : remaining <= 0
            ? Colors.red
            : remaining <= 30
                ? Colors.orange
                : Colors.green;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Code $code  •  ${r.activationDays} days activation',
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'monospace'),
          ),
          const SizedBox(height: 4),
          Text(
            'Activated ${formatDateShort(r.promoUsedAt)}  •  expires ${formatDateShort(r.promoExpiresAt)}',
            style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
          ),
          if (remaining != null) ...[
            const SizedBox(height: 4),
            Text(
              remaining <= 0 ? 'Expired ${pluralDays(-remaining)} ago' : '$remaining days remaining',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: expColor),
            ),
          ],
        ],
      ),
    );
  }

  Widget _staffBlock(ColorScheme cs) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text('Staff PINs:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: cs.onSurfaceVariant)),
        _pinChip(cs, 'Admin', r.pinAdminSet),
        _pinChip(cs, 'Waiter', r.pinWaiterSet),
        _pinChip(cs, 'Kitchen', r.pinKitchenSet),
      ],
    );
  }

  Widget _pinChip(ColorScheme cs, String label, bool set) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: chipBackground(cs, set ? Colors.green : cs.outline),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(set ? Icons.check_circle : Icons.remove_circle_outline, size: 14, color: set ? Colors.green.shade700 : cs.outline),
          const SizedBox(width: 4),
          Text('$label PIN ${set ? 'set' : '—'}', style: TextStyle(fontSize: 12, color: set ? Colors.green.shade800 : cs.onSurfaceVariant)),
        ],
      ),
    );
  }

  Widget _stat(ColorScheme cs, IconData icon, int value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: cs.onSurfaceVariant),
        const SizedBox(width: 4),
        Text('$value $label', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: cs.onSurfaceVariant)),
      ],
    );
  }

  Widget _chip(ColorScheme cs, Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: chipBackground(cs, color), borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
    );
  }
}
