import 'package:flutter/material.dart';

import '../data/admin_repository.dart';
import '../models/admin_report.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final _repo = AdminRepository();
  AdminReport? _report;
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
      final data = await _repo.fetchReport();
      if (mounted) {
        setState(() {
          _report = data;
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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (_loading && _report == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null && _report == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 48, color: kDanger),
            const SizedBox(height: 12),
            const Text('Failed to load reports'),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }
    final r = _report!;
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        children: [
          _header(cs, r),
          const SizedBox(height: 16),
          _statGrid(r),
          const SizedBox(height: 20),
          _statusCard(r),
          const SizedBox(height: 14),
          _trendCard(r),
          const SizedBox(height: 14),
          _topItemsCard(r),
          const SizedBox(height: 20),
          _sectionTitle(cs, 'Per restaurant'),
          const SizedBox(height: 10),
          if (r.restaurants.isEmpty)
            _emptyNote(cs, 'No restaurant accounts yet.')
          else
            ...r.restaurants.map((x) => _RestaurantCard(x: x)),
          const SizedBox(height: 20),
          _sectionTitle(cs, 'Accounts & promo codes'),
          const SizedBox(height: 10),
          _activityCard(r),
        ],
      ),
    );
  }

  Widget _header(ColorScheme cs, AdminReport r) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reports',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, letterSpacing: -0.6, color: cs.onSurface),
              ),
              const SizedBox(height: 3),
              Text(
                'Updated ${formatDateShort(r.generatedAt)}',
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

  Widget _sectionTitle(ColorScheme cs, String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, letterSpacing: -0.3, color: cs.onSurface),
    );
  }

  Widget _statGrid(AdminReport r) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _statTile(Icons.storefront_rounded, '${r.accounts.total}', 'Restaurants', kAccent)),
            const SizedBox(width: 12),
            Expanded(child: _statTile(Icons.receipt_long_rounded, '${r.orders.total}', 'Orders', kInfo)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _statTile(Icons.payments_outlined, formatCompact(r.orders.revenue), 'Revenue', kSuccess)),
            const SizedBox(width: 12),
            Expanded(child: _statTile(Icons.shopping_basket_outlined, '${r.orders.items}', 'Items sold', kWarning)),
          ],
        ),
      ],
    );
  }

  Widget _statTile(IconData icon, String value, String label, Color color) {
    final cs = Theme.of(context).colorScheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF15161C) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: (dark ? Colors.white : const Color(0xFF111827)).withValues(alpha: dark ? 0.10 : 0.07)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.14), borderRadius: BorderRadius.circular(13)),
            child: Icon(icon, size: 21, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, letterSpacing: -0.4, color: cs.onSurface),
                  ),
                ),
                Text(label, style: TextStyle(fontSize: 11.5, color: cs.onSurfaceVariant), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(ColorScheme cs, Widget child) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF15161C) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: (dark ? Colors.white : const Color(0xFF111827)).withValues(alpha: dark ? 0.10 : 0.07)),
      ),
      child: child,
    );
  }

  Widget _cardTitle(ColorScheme cs, IconData icon, String text, {Widget? trailing}) {
    return Row(
      children: [
        Icon(icon, size: 17, color: kAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: cs.onSurface)),
        ),
        ?trailing,
      ],
    );
  }

  Widget _statusCard(AdminReport r) {
    final cs = Theme.of(context).colorScheme;
    final total = r.orders.total;
    final rows = [
      ('Served', r.orders.served, kSuccess, Icons.check_circle_rounded),
      ('Preparing', r.orders.preparing, kInfo, Icons.local_dining_rounded),
      ('Pending', r.orders.pending, kWarning, Icons.schedule_rounded),
    ];
    return _card(
      cs,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardTitle(cs, Icons.assessment_rounded, 'Orders by status', trailing: Text('$total total', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: cs.onSurfaceVariant))),
          const SizedBox(height: 16),
          if (total == 0)
            Text('No orders yet.', style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant))
          else
            ...rows.map((row) {
              final (label, count, color, icon) = row;
              final frac = count / total;
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon, size: 15, color: color),
                        const SizedBox(width: 8),
                        Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: cs.onSurface)),
                        const Spacer(),
                        Text('$count · ${(frac * 100).round()}%', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: cs.onSurfaceVariant)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: frac,
                        minHeight: 8,
                        backgroundColor: cs.outlineVariant.withValues(alpha: 0.35),
                        valueColor: AlwaysStoppedAnimation(color),
                      ),
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _trendCard(AdminReport r) {
    final cs = Theme.of(context).colorScheme;
    final days = r.orders.byDay;
    final maxOrders = days.fold<int>(0, (m, d) => d.orders > m ? d.orders : m);
    return _card(
      cs,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardTitle(cs, Icons.bar_chart_rounded, 'Orders — last 14 days'),
          const SizedBox(height: 18),
          if (days.isEmpty || maxOrders == 0)
            Text('No orders yet.', style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant))
          else
            SizedBox(
              height: 130,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: days.map((d) {
                  final h = maxOrders == 0 ? 0.0 : d.orders / maxOrders;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (d.orders > 0)
                            Text('${d.orders}', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: cs.onSurfaceVariant)),
                          const SizedBox(height: 3),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: FractionallySizedBox(
                                heightFactor: h.clamp(0, 1).toDouble(),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [kAccent, Color(0xFFB15CFF)],
                                    ),
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text('${d.day.day}', style: TextStyle(fontSize: 9, color: cs.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _topItemsCard(AdminReport r) {
    final cs = Theme.of(context).colorScheme;
    final items = r.topItems;
    final maxQty = items.fold<int>(0, (m, i) => i.qty > m ? i.qty : m);
    return _card(
      cs,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardTitle(cs, Icons.emoji_food_beverage_rounded, 'Top selling items'),
          const SizedBox(height: 14),
          if (items.isEmpty)
            Text('No orders yet.', style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant))
          else
            ...items.indexed.map((entry) {
              final (index, item) = entry;
              final frac = maxQty == 0 ? 0.0 : item.qty / maxQty;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: index < 3 ? kAccent.withValues(alpha: 0.14) : cs.outlineVariant.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: index < 3 ? kAccent : cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: cs.onSurface), overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 5),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: frac,
                              minHeight: 5,
                              backgroundColor: cs.outlineVariant.withValues(alpha: 0.35),
                              valueColor: AlwaysStoppedAnimation(index < 3 ? kAccent : cs.outlineVariant),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${item.qty}×', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: cs.onSurface)),
                        Text(formatCompact(item.revenue), style: TextStyle(fontSize: 11.5, color: cs.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _activityCard(AdminReport r) {
    final cs = Theme.of(context).colorScheme;
    final a = r.accounts;
    final p = r.promos;
    return _card(
      cs,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardTitle(cs, Icons.people_outline_rounded, 'Accounts'),
          const SizedBox(height: 14),
          _metricRow(cs, 'Activated', '${a.activated}', kSuccess),
          _metricRow(cs, 'Not activated', '${a.notActivated}', kWarning),
          _metricRow(cs, 'Joined last 30d', '${a.joined30d}', kInfo),
          _metricRow(cs, 'Joined last 90d', '${a.joined90d}', kInfo),
          _metricRow(cs, 'Admin PIN set', '${a.withAdminPin}', kAccent),
          _metricRow(cs, 'Waiter PIN set', '${a.withWaiterPin}', kAccent),
          _metricRow(cs, 'Kitchen PIN set', '${a.withKitchenPin}', kAccent),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Divider(height: 1),
          ),
          _cardTitle(cs, Icons.vpn_key_rounded, 'Promo codes'),
          const SizedBox(height: 14),
          _metricRow(cs, 'Available', '${p.available}', kInfo),
          _metricRow(cs, 'Used', '${p.used}', kSuccess),
          _metricRow(cs, 'Expired', '${p.expired}', kDanger),
          _metricRow(cs, 'Expiring in 30d', '${p.expiring30d}', kWarning),
        ],
      ),
    );
  }

  Widget _metricRow(ColorScheme cs, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color.withValues(alpha: 0.6), shape: BoxShape.circle)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: TextStyle(fontSize: 13.5, color: cs.onSurfaceVariant)),
          ),
          Text(value, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: cs.onSurface)),
        ],
      ),
    );
  }

  Widget _emptyNote(ColorScheme cs, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(text, style: TextStyle(fontSize: 13, color: cs.onSurfaceVariant)),
      ),
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final RestaurantReport x;
  const _RestaurantCard({required this.x});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final remaining = x.promoExpires?.difference(DateTime.now()).inDays;
    final isExpired = remaining != null && remaining <= 0;
    final statusColor = !x.activated ? kWarning : isExpired ? kDanger : kSuccess;
    final statusLabel = !x.activated ? 'Not activated' : isExpired ? 'Expired' : 'Active';
    final color = colorForEmail(x.email);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
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
                    avatarInitials(x.email),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(x.email, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w700), overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 3),
                      Text(
                        '${formatDateShort(x.joined)}${x.promoCode != null ? '  •  code ${x.promoCode}' : ''}',
                        style: TextStyle(fontSize: 11.5, color: cs.onSurfaceVariant),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 7, height: 7, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Text(statusLabel, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: statusColor)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(child: _valueBox(cs, Icons.receipt_long_rounded, '${x.orders}', 'Orders', kInfo)),
                const SizedBox(width: 10),
                Expanded(child: _valueBox(cs, Icons.payments_outlined, formatCompact(x.revenue), 'Revenue', kSuccess)),
                const SizedBox(width: 10),
                Expanded(child: _valueBox(cs, Icons.shopping_basket_outlined, '${x.items}', 'Items', kWarning)),
                const SizedBox(width: 10),
                Expanded(child: _valueBox(cs, Icons.trending_up_rounded, formatCompact(x.avgOrderValue), 'Avg order', kAccent)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                _miniChip(cs, '${x.recipes} recipes', Icons.restaurant_menu_rounded),
                const SizedBox(width: 8),
                _miniChip(cs, '${x.pinAdmin ? 'Admin' : 'No'} PIN', Icons.admin_panel_settings_outlined),
                const SizedBox(width: 8),
                _miniChip(cs, '${x.pinWaiter ? 'Waiter' : 'No'} PIN', Icons.room_service_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _valueBox(ColorScheme cs, IconData icon, String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 5),
              Expanded(
                child: Text(label, style: TextStyle(fontSize: 10.5, color: cs.onSurfaceVariant), overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: -0.3, color: cs.onSurface)),
          ),
        ],
      ),
    );
  }

  Widget _miniChip(ColorScheme cs, String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.outlineVariant.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: cs.onSurfaceVariant),
          const SizedBox(width: 5),
          Text(text, style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: cs.onSurfaceVariant)),
        ],
      ),
    );
  }
}
