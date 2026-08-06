import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/admin_repository.dart';
import '../models/promo_code_summary.dart';
import '../utils/format.dart';

class PromoCodesPage extends StatefulWidget {
  const PromoCodesPage({super.key});

  @override
  State<PromoCodesPage> createState() => _PromoCodesPageState();
}

class _PromoCodesPageState extends State<PromoCodesPage> {
  final _repo = AdminRepository();
  List<PromoCodeSummary>? _codes;
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
      final data = await _repo.listPromoCodes();
      if (mounted) {
        setState(() {
          _codes = data;
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

  void _copy(String code) {
    Clipboard.setData(ClipboardData(text: code));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Code copied'), duration: Duration(seconds: 1)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Widget body;
    if (_loading && _codes == null) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_error != null && _codes == null) {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            const Text('Failed to load promo codes'),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    } else if (_codes == null || _codes!.isEmpty) {
      body = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.vpn_key_off_outlined, size: 56, color: cs.outline),
            const SizedBox(height: 12),
            const Text('No promo codes yet'),
          ],
        ),
      );
    } else {
      body = RefreshIndicator(
        onRefresh: _load,
        child: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: _codes!.length,
          itemBuilder: (context, i) => _PromoCard(c: _codes![i], onCopy: _copy),
        ),
      );
    }
    return Scaffold(body: body);
  }
}

class _PromoCard extends StatelessWidget {
  final PromoCodeSummary c;
  final void Function(String code) onCopy;
  const _PromoCard({required this.c, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final Color statusColor;
    final String statusText;
    if (c.isUsed) {
      statusColor = Colors.green;
      statusText = 'Used';
    } else if (c.isExpired) {
      statusColor = Colors.red;
      statusText = 'Expired';
    } else {
      statusColor = Colors.blue;
      statusText = 'Available';
    }
    final days = c.activationDays;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    c.code,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, fontFamily: 'monospace', letterSpacing: 1),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(statusText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: statusColor)),
                ),
                IconButton(
                  icon: Icon(Icons.copy_rounded, size: 18, color: cs.primary),
                  tooltip: 'Copy',
                  onPressed: () => onCopy(c.code),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (c.isUsed) ...[
              Text('Claimed by ${c.usedByEmail ?? '-'}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              if (days != null) Text('Activation duration: $days days', style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
            ],
            const SizedBox(height: 4),
            Text(
              'Created ${formatDateShort(c.createdAt)}'
              '${c.usedAt != null ? '  •  used ${formatDateShort(c.usedAt)}' : ''}'
              '${c.expiresAt != null ? '  •  expires ${formatDateShort(c.expiresAt)}' : ''}',
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
