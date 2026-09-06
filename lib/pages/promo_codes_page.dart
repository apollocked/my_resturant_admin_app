import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/helpers/responsive.dart';
import '../data/admin_repository.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/promo_code_summary.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';
import '../widgets/add_promo_code_sheet.dart';
import '../widgets/empty_state.dart';
import '../widgets/shimmer_skeletons.dart';

enum _CodeFilter { all, used, available, expired }

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
  _CodeFilter _filter = _CodeFilter.all;

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

  List<PromoCodeSummary> get _filtered {
    final list = _codes ?? const <PromoCodeSummary>[];
    return switch (_filter) {
      _CodeFilter.all => list,
      _CodeFilter.used => list.where((c) => c.isUsed).toList(),
      _CodeFilter.available =>
        list.where((c) => !c.isUsed && !c.isExpired).toList(),
      _CodeFilter.expired => list.where((c) => c.isExpired).toList(),
    };
  }

  void _copy(String code) {
    Clipboard.setData(ClipboardData(text: code));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).codeCopied),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _openAdd() async {
    final code = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => const AddPromoCodeSheet(),
    );
    if (code == null) return;
    await _load();
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.promoCodeMinted(code)),
        action: SnackBarAction(label: l10n.copy, onPressed: () => _copy(code)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    if (_loading && _codes == null) {
      return ShimmerListView(itemCount: 4, itemBuilder: () => const ShimmerCard());
    }
    if (_error != null && _codes == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off_rounded, size: 48, color: kDanger),
            const SizedBox(height: 12),
            Text(l10n.failedToLoadPromoCodes),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: _load, child: Text(l10n.retry)),
          ],
        ),
      );
    }
    final list = _filtered;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAdd,
        backgroundColor: kAccent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: Text(
          l10n.addCode,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: EdgeInsets.fromLTRB(R.padding(context), 8, R.padding(context), 100),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.promoCodesTitle,
                        style: TextStyle(
                          fontSize: R.fontXxl(context),
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.6,
                          color: cs.onSurface,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        l10n.codesMinted(_codes?.length ?? 0),
                        style: TextStyle(
                          fontSize: 13,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _filterChips(cs, l10n),
            const SizedBox(height: 14),
            if (list.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: EmptyState(
                  icon: _filter == _CodeFilter.all
                      ? Icons.vpn_key_off_outlined
                      : Icons.filter_alt_off_rounded,
title: _filter == _CodeFilter.all
                              ? l10n.noPromoCodesYet
                              : l10n.nothingHere,
                          subtitle: _filter == _CodeFilter.all
                              ? l10n.noPromoCodesSubtitle
                              : l10n.noFilterSubtitle,
                ),
              )
            else
              ...list.map((c) => _PromoCard(c: c, onCopy: _copy)),
          ],
        ),
      ),
    );
  }

  Widget _filterChips(ColorScheme cs, AppLocalizations l10n) {
    Widget chip(_CodeFilter f, String label) {
      final count = switch (f) {
        _CodeFilter.all => _codes?.length ?? 0,
        _CodeFilter.used => _codes?.where((c) => c.isUsed).length ?? 0,
        _CodeFilter.available =>
          _codes?.where((c) => !c.isUsed && !c.isExpired).length ?? 0,
        _CodeFilter.expired => _codes?.where((c) => c.isExpired).length ?? 0,
      };
      return Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(
          label: Text('$label  $count'),
          selected: _filter == f,
          onSelected: (_) => setState(() => _filter = f),
          showCheckmark: false,
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          chip(_CodeFilter.all, l10n.filterAll),
          chip(_CodeFilter.used, l10n.filterUsed),
          chip(_CodeFilter.available, l10n.filterAvailable),
          chip(_CodeFilter.expired, l10n.filterExpired),
        ],
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final PromoCodeSummary c;
  final void Function(String code) onCopy;
  const _PromoCard({required this.c, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context);
    final Color statusColor;
    final String statusText;
    if (c.isUsed) {
      statusColor = kSuccess;
      statusText = l10n.statusUsed;
    } else if (c.isExpired) {
      statusColor = kDanger;
      statusText = l10n.statusExpired;
    } else {
      statusColor = kInfo;
      statusText = l10n.statusAvailable;
    }
    final days = c.activationDays;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 5,
              height: 58,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          c.code,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.5,
                            color: cs.onSurface,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              statusText,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: statusColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (c.isUsed) ...[
                    Text(
                      c.usedByEmail == null
                          ? l10n.claimedByUnknown
                          : l10n.claimedBy(c.usedByEmail!),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (days != null)
                      Text(
                        l10n.activationDurationDays(days),
                        style: TextStyle(
                          fontSize: 12,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    [
                      l10n.createdOn(formatDateShortL10n(c.createdAt, l10n)),
                      if (c.usedAt != null) l10n.usedOn(formatDateShortL10n(c.usedAt, l10n)),
                      if (c.expiresAt != null) l10n.expiresOn(formatDateShortL10n(c.expiresAt, l10n)),
                    ].join('  •  '),
                    style: TextStyle(
                      fontSize: 11.5,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy_rounded, size: 18, color: cs.primary),
              tooltip: l10n.copy,
              onPressed: () => onCopy(c.code),
            ),
          ],
        ),
      ),
    );
  }
}
