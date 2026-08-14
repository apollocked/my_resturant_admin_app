import 'package:flutter/material.dart';

import '../core/helpers/responsive.dart';
import '../data/admin_repository.dart';
import '../models/restaurant_summary.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/add_restaurant_sheet.dart';
import '../widgets/empty_state.dart';
import '../widgets/shimmer_skeletons.dart';

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
  String _query = '';
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
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

  List<RestaurantSummary> get _filtered {
    final list = _restaurants ?? const <RestaurantSummary>[];
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return list;
    return list.where((r) => r.email.toLowerCase().contains(q)).toList();
  }

  Future<void> _openAdd() async {
    final code = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (_) => const AddRestaurantSheet(),
    );
    if (code == null) return;
    await _load();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          code.isEmpty ? 'Restaurant created.' : 'Restaurant created. Promo code: $code',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;
    if (_loading && _restaurants == null) {
      return ShimmerListView(itemCount: 4, itemBuilder: () => const ShimmerCard());
    }
    if (_error != null && _restaurants == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 48, color: kDanger),
            const SizedBox(height: 12),
            const Text('Failed to load restaurants'),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAdd,
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add restaurant', style: TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: EdgeInsets.fromLTRB(R.padding(context), 8, R.padding(context), 100),
          children: [
            _header(),
            const SizedBox(height: 16),
            _statGrid(),
            const SizedBox(height: 20),
            _searchField(),
            const SizedBox(height: 14),
            if (list.isEmpty)
              _emptyState(_restaurants!.isEmpty)
            else
              ...list.map((r) => _RestaurantCard(r: r)),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Restaurants',
                style: TextStyle(
                  fontSize: R.fontXxl(context),
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.6,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '${_restaurants?.length ?? 0} registered accounts',
                style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(color: kSuccess, shape: BoxShape.circle),
        ),
      ],
    );
  }

  Widget _statGrid() {
    final list = _restaurants ?? const <RestaurantSummary>[];
    final total = list.length;
    final activated = list.where((r) => r.activated).length;
    final active = list.where((r) => r.activated && (r.daysRemaining ?? -1) > 0).length;
    final expiring = list
        .where((r) {
          final d = r.daysRemaining;
          return r.activated && d != null && d > 0 && d <= 30;
        })
        .length;
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _statTile(Icons.storefront_rounded, total, 'Total', kAccent)),
            const SizedBox(width: 12),
            Expanded(child: _statTile(Icons.check_circle_rounded, activated, 'Activated', kSuccess)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _statTile(Icons.bolt_rounded, active, 'Active subs', kInfo)),
            const SizedBox(width: 12),
            Expanded(child: _statTile(Icons.schedule_rounded, expiring, 'Expiring ≤30d', kWarning)),
          ],
        ),
      ],
    );
  }

  Widget _statTile(IconData icon, int value, String label, Color color) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, size: 21, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$value',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.4, color: cs.onSurface),
                ),
                Text(label, style: TextStyle(fontSize: 11.5, color: cs.onSurfaceVariant), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: _searchCtrl,
      onChanged: (v) => setState(() => _query = v),
      decoration: InputDecoration(
        hintText: 'Search by email…',
        prefixIcon: const Icon(Icons.search_rounded, size: 20),
        suffixIcon: _query.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close_rounded, size: 18),
                onPressed: () {
                  _searchCtrl.clear();
                  setState(() => _query = '');
                },
              ),
      ),
    );
  }

  Widget _emptyState(bool noData) {
    return EmptyState(
      icon: noData ? Icons.storefront_outlined : Icons.search_off_rounded,
      title: noData ? 'No restaurants yet' : 'No matches',
      subtitle: noData
          ? 'Tap "Add restaurant" to create the first one.'
          : 'Try a different search.',
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final RestaurantSummary r;
  const _RestaurantCard({required this.r});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    final remaining = r.daysRemaining;
    final isExpired = remaining != null && remaining <= 0;
    final statusColor = !r.activated
        ? kWarning
        : isExpired
            ? kDanger
            : kSuccess;
    final statusLabel = !r.activated
        ? 'Not activated'
        : isExpired
            ? 'Expired'
            : 'Activated';
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _avatar(cs),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r.email,
                        style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Joined ${formatDateShort(r.createdAt)}',
                        style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                _statusPill(statusColor, statusLabel),
              ],
            ),
            const SizedBox(height: 14),
            _promoBlock(cs, dark, remaining, isExpired),
            const SizedBox(height: 12),
            _staffBlock(cs),
            const SizedBox(height: 12),
            Divider(color: cs.outlineVariant.withValues(alpha: 0.5)),
            const SizedBox(height: 10),
            Row(
              children: [
                _stat(cs, Icons.restaurant_menu_rounded, r.recipesCount, 'recipes'),
                const SizedBox(width: 20),
                _stat(cs, Icons.receipt_long_rounded, r.ordersCount, 'orders'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatar(ColorScheme cs) {
    final color = colorForEmail(r.email);
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color, color.withValues(alpha: 0.6)],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: Text(
        avatarInitials(r.email),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
      ),
    );
  }

  Widget _statusPill(Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }

  Widget _promoBlock(ColorScheme cs, bool dark, int? remaining, bool isExpired) {
    final code = r.promoCode;
    if (code == null) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: (dark ? Colors.white : const Color(0xFF111827)).withValues(alpha: dark ? 0.05 : 0.04),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text('No promo code claimed yet', style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant)),
      );
    }
    final total = r.activationDays;
    final fraction = total > 0 && remaining != null ? (remaining / total).clamp(0.0, 1.0) : 0.0;
    final barColor = isExpired ? kDanger : (remaining != null && remaining <= 30 ? kWarning : kSuccess);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (dark ? Colors.white : const Color(0xFF111827)).withValues(alpha: dark ? 0.05 : 0.04),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.vpn_key_rounded, size: 16, color: kAccent),
              const SizedBox(width: 8),
              Text(
                'Activation  •  $total days',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                remaining == null
                    ? '—'
                    : isExpired
                        ? 'Expired'
                        : '$remaining days left',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: isExpired ? kDanger : kAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 8,
              backgroundColor: cs.outlineVariant.withValues(alpha: 0.4),
              valueColor: AlwaysStoppedAnimation(barColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Code $code  •  ${formatDateShort(r.promoUsedAt)}  →  ${formatDateShort(r.promoExpiresAt)}',
            style: TextStyle(fontSize: 11.5, color: cs.onSurfaceVariant, fontFamily: 'monospace'),
          ),
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
        Text('Staff PINs:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: cs.onSurfaceVariant)),
        _pinChip(cs, 'Admin', r.pinAdminSet),
        _pinChip(cs, 'Waiter', r.pinWaiterSet),
        _pinChip(cs, 'Kitchen', r.pinKitchenSet),
      ],
    );
  }

  Widget _pinChip(ColorScheme cs, String label, bool set) {
    final color = set ? kSuccess : cs.outline;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: color.withValues(alpha: set ? 0.12 : 0.06), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(set ? Icons.check_circle_rounded : Icons.remove_circle_outline_rounded, size: 13, color: set ? color : cs.outline),
          const SizedBox(width: 5),
          Text(
            '$label PIN ${set ? 'set' : '—'}',
            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: set ? color : cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  Widget _stat(ColorScheme cs, IconData icon, int value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: cs.onSurfaceVariant),
        const SizedBox(width: 5),
        Text('$value $label', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: cs.onSurfaceVariant)),
      ],
    );
  }
}
