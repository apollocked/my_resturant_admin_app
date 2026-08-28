import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/helpers/responsive.dart';
import '../core/theme/app_colors.dart';
import '../data/admin_repository.dart';
import '../theme/app_theme.dart';
import '../widgets/connectivity_banner.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/liquid_glass_nav_bar.dart';
import '../widgets/tab_entrance.dart';
import '../widgets/app_logo.dart';
import 'promo_codes_page.dart';
import 'reports_page.dart';
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

  Future<void> _confirmSignOut() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Sign out?',
      message: 'Are you sure you want to sign out of My Rest Admin?',
      confirmLabel: 'Sign out',
      icon: Icons.logout_rounded,
      destructive: true,
    );
    if (confirmed) await _repo.signOut();
  }

  Widget _brand(double size) {
    return AppLogo(size: size, borderRadiusFactor: 0.3);
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
            padding: EdgeInsets.all(R.padding(context)),
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
                Text('Access denied', style: TextStyle(fontSize: R.fontXl(context), fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Text(
                  'Only the platform admin can use this app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: _confirmSignOut,
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text('Sign out'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    final pages = const [RestaurantsPage(), PromoCodesPage(), ReportsPage()];
    final isDesktop = R.isDesktop(context);
    final isTablet = R.isTablet(context);

    if ((isDesktop || isTablet) && R.height(context) >= 500) {
      return _exitScope(
        SafeArea(
          child: ConnectivityBanner(
            child: Scaffold(
              body: Row(
                children: [
                  NavigationRail(
                    selectedIndex: _index,
                    onDestinationSelected: (i) {
                      HapticFeedback.selectionClick();
                      setState(() => _index = i);
                    },
                    labelType: NavigationRailLabelType.all,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    indicatorColor: AppColors.primarySoft,
                    leading: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _brand(36),
                          const SizedBox(height: 6),
                          const Text(
                            'My Rest Admin',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    minWidth: 108,
                    groupAlignment: 0,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.storefront_outlined, size: 24),
                        selectedIcon: Icon(Icons.storefront_rounded, size: 24),
                        label: Text('Restaurants'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.vpn_key_outlined, size: 24),
                        selectedIcon: Icon(Icons.vpn_key_rounded, size: 24),
                        label: Text('Promo Codes'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.insert_chart_outlined_rounded, size: 24),
                        selectedIcon: Icon(Icons.insert_chart_rounded, size: 24),
                        label: Text('Reports'),
                      ),
                    ],
                    trailing: Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: IconButton(
                            tooltip: 'Sign out',
                            onPressed: _confirmSignOut,
                            icon: const Icon(Icons.logout_rounded),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: TabEntrance(
                      index: _index,
                      child: IndexedStack(index: _index, children: pages),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return _exitScope(
      SafeArea(
        child: ConnectivityBanner(
          child: Scaffold(
            extendBody: true,
            appBar: AppBar(
              title: Row(
                children: [
                  _brand(28),
                  const SizedBox(width: 10),
                  const Text('My Rest Admin'),
                ],
              ),
              actions: [
                IconButton(
                  tooltip: 'Sign out',
                  icon: const Icon(Icons.logout_rounded),
                  onPressed: _confirmSignOut,
                ),
              ],
            ),
            body: SafeArea(
              top: true,
              bottom: false,
              child: TabEntrance(
                index: _index,
                child: IndexedStack(index: _index, children: pages),
              ),
            ),
            bottomNavigationBar: LiquidGlassNavBar(
              items: const [
                LiquidNavItem(icon: Icons.storefront_outlined, activeIcon: Icons.storefront_rounded, label: 'Restaurants'),
                LiquidNavItem(icon: Icons.vpn_key_outlined, activeIcon: Icons.vpn_key_rounded, label: 'Promo Codes'),
                LiquidNavItem(icon: Icons.insert_chart_outlined_rounded, activeIcon: Icons.insert_chart_rounded, label: 'Reports'),
              ],
              selectedIndex: _index,
              onTap: (i) {
                debugPrint('[NAV] tab=$i');
                HapticFeedback.selectionClick();
                setState(() => _index = i);
              },
              accentColor: AppColors.primary,
              isDark: dark,
            ),
          ),
        ),
      ),
    );
  }

  Widget _exitScope(Widget child) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmExit(context);
      },
      child: child,
    );
  }

  Future<void> _confirmExit(BuildContext context) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Exit My Rest Admin?',
      message: 'Are you sure you want to close the app?',
      confirmLabel: 'Exit',
      icon: Icons.exit_to_app_rounded,
      destructive: true,
    );
    if (confirmed) SystemNavigator.pop();
  }
}
