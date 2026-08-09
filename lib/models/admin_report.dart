class AdminReport {
  final DateTime generatedAt;
  final AccountStats accounts;
  final PromoStats promos;
  final OrderStats orders;
  final List<RestaurantReport> restaurants;
  final List<TopItem> topItems;

  AdminReport({
    required this.generatedAt,
    required this.accounts,
    required this.promos,
    required this.orders,
    required this.restaurants,
    required this.topItems,
  });

  factory AdminReport.fromJson(Map<String, dynamic> json) {
    final accountsJson = json['accounts'] as Map<String, dynamic>? ?? const {};
    final promosJson = json['promos'] as Map<String, dynamic>? ?? const {};
    final ordersJson = json['orders'] as Map<String, dynamic>? ?? const {};
    return AdminReport(
      generatedAt:
          DateTime.tryParse(json['generated_at']?.toString() ?? '')?.toLocal() ??
              DateTime.now(),
      accounts: AccountStats.fromJson(accountsJson),
      promos: PromoStats.fromJson(promosJson),
      orders: OrderStats.fromJson(ordersJson),
      restaurants: ((json['restaurants'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(RestaurantReport.fromJson)
          .toList(),
      topItems: ((json['top_items'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(TopItem.fromJson)
          .toList(),
    );
  }
}

class AccountStats {
  final int total;
  final int activated;
  final int notActivated;
  final int joined30d;
  final int joined90d;
  final int withAdminPin;
  final int withWaiterPin;
  final int withKitchenPin;

  AccountStats({
    required this.total,
    required this.activated,
    required this.notActivated,
    required this.joined30d,
    required this.joined90d,
    required this.withAdminPin,
    required this.withWaiterPin,
    required this.withKitchenPin,
  });

  factory AccountStats.fromJson(Map<String, dynamic> json) => AccountStats(
        total: (json['total'] as num?)?.toInt() ?? 0,
        activated: (json['activated'] as num?)?.toInt() ?? 0,
        notActivated: (json['not_activated'] as num?)?.toInt() ?? 0,
        joined30d: (json['joined_30d'] as num?)?.toInt() ?? 0,
        joined90d: (json['joined_90d'] as num?)?.toInt() ?? 0,
        withAdminPin: (json['with_admin_pin'] as num?)?.toInt() ?? 0,
        withWaiterPin: (json['with_waiter_pin'] as num?)?.toInt() ?? 0,
        withKitchenPin: (json['with_kitchen_pin'] as num?)?.toInt() ?? 0,
      );
}

class PromoStats {
  final int total;
  final int used;
  final int available;
  final int expired;
  final int expiring30d;

  PromoStats({
    required this.total,
    required this.used,
    required this.available,
    required this.expired,
    required this.expiring30d,
  });

  factory PromoStats.fromJson(Map<String, dynamic> json) => PromoStats(
        total: (json['total'] as num?)?.toInt() ?? 0,
        used: (json['used'] as num?)?.toInt() ?? 0,
        available: (json['available'] as num?)?.toInt() ?? 0,
        expired: (json['expired'] as num?)?.toInt() ?? 0,
        expiring30d: (json['expiring_30d'] as num?)?.toInt() ?? 0,
      );
}

class OrderStats {
  final int total;
  final double revenue;
  final int items;
  final Map<String, int> byStatus;
  final List<DayPoint> byDay;

  OrderStats({
    required this.total,
    required this.revenue,
    required this.items,
    required this.byStatus,
    required this.byDay,
  });

  int get pending => byStatus['pending'] ?? 0;
  int get preparing => byStatus['preparing'] ?? 0;
  int get served => byStatus['served'] ?? 0;

  factory OrderStats.fromJson(Map<String, dynamic> json) {
    final statusJson = json['by_status'] as Map<String, dynamic>? ?? const {};
    return OrderStats(
      total: (json['total'] as num?)?.toInt() ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0,
      items: (json['items'] as num?)?.toInt() ?? 0,
      byStatus: statusJson.map((k, v) => MapEntry(k, (v as num?)?.toInt() ?? 0)),
      byDay: ((json['by_day'] as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(DayPoint.fromJson)
          .toList(),
    );
  }
}

class DayPoint {
  final DateTime day;
  final int orders;
  final double revenue;

  DayPoint({required this.day, required this.orders, required this.revenue});

  factory DayPoint.fromJson(Map<String, dynamic> json) => DayPoint(
        day: DateTime.tryParse(json['day']?.toString() ?? '')?.toLocal() ??
            DateTime.now(),
        orders: (json['orders'] as num?)?.toInt() ?? 0,
        revenue: (json['revenue'] as num?)?.toDouble() ?? 0,
      );
}

class RestaurantReport {
  final String email;
  final bool activated;
  final DateTime joined;
  final String? promoCode;
  final DateTime? promoExpires;
  final bool pinAdmin;
  final bool pinWaiter;
  final bool pinKitchen;
  final int recipes;
  final int orders;
  final int items;
  final double revenue;

  RestaurantReport({
    required this.email,
    required this.activated,
    required this.joined,
    required this.promoCode,
    required this.promoExpires,
    required this.pinAdmin,
    required this.pinWaiter,
    required this.pinKitchen,
    required this.recipes,
    required this.orders,
    required this.items,
    required this.revenue,
  });

  double get avgOrderValue => orders > 0 ? revenue / orders : 0;

  factory RestaurantReport.fromJson(Map<String, dynamic> json) =>
      RestaurantReport(
        email: json['email']?.toString() ?? '—',
        activated: json['activated'] == true,
        joined: DateTime.tryParse(json['joined']?.toString() ?? '')?.toLocal() ??
            DateTime.now(),
        promoCode: json['promo_code']?.toString(),
        promoExpires:
            DateTime.tryParse(json['promo_expires']?.toString() ?? '')?.toLocal(),
        pinAdmin: json['pin_admin'] == true,
        pinWaiter: json['pin_waiter'] == true,
        pinKitchen: json['pin_kitchen'] == true,
        recipes: (json['recipes'] as num?)?.toInt() ?? 0,
        orders: (json['orders'] as num?)?.toInt() ?? 0,
        items: (json['items'] as num?)?.toInt() ?? 0,
        revenue: (json['revenue'] as num?)?.toDouble() ?? 0,
      );
}

class TopItem {
  final String name;
  final int qty;
  final double revenue;

  TopItem({required this.name, required this.qty, required this.revenue});

  factory TopItem.fromJson(Map<String, dynamic> json) => TopItem(
        name: json['name']?.toString() ?? '—',
        qty: (json['qty'] as num?)?.toInt() ?? 0,
        revenue: (json['revenue'] as num?)?.toDouble() ?? 0,
      );
}
