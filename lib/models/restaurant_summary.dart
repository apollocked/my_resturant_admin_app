class RestaurantSummary {
  final String id;
  final String email;
  final String? role;
  final bool activated;
  final DateTime? createdAt;
  final bool pinAdminSet;
  final bool pinWaiterSet;
  final bool pinKitchenSet;
  final String? promoCode;
  final DateTime? promoUsedAt;
  final DateTime? promoExpiresAt;
  final int recipesCount;
  final int ordersCount;

  const RestaurantSummary({
    required this.id,
    required this.email,
    required this.activated,
    required this.pinAdminSet,
    required this.pinWaiterSet,
    required this.pinKitchenSet,
    required this.recipesCount,
    required this.ordersCount,
    this.role,
    this.createdAt,
    this.promoCode,
    this.promoUsedAt,
    this.promoExpiresAt,
  });

  factory RestaurantSummary.fromJson(Map<String, dynamic> row) {
    return RestaurantSummary(
      id: row['id'] as String? ?? '',
      email: row['email'] as String? ?? '',
      role: row['role'] as String?,
      activated: row['activated'] == true,
      createdAt: _parseDate(row['created_at']),
      pinAdminSet: row['pin_admin_set'] == true,
      pinWaiterSet: row['pin_waiter_set'] == true,
      pinKitchenSet: row['pin_kitchen_set'] == true,
      promoCode: row['promo_code'] as String?,
      promoUsedAt: _parseDate(row['promo_used_at']),
      promoExpiresAt: _parseDate(row['promo_expires_at']),
      recipesCount: (row['recipes_count'] as num?)?.toInt() ?? 0,
      ordersCount: (row['orders_count'] as num?)?.toInt() ?? 0,
    );
  }

  static DateTime? _parseDate(dynamic v) {
    if (v == null) return null;
    return DateTime.tryParse(v.toString());
  }

  int get activationDays =>
      promoUsedAt != null && promoExpiresAt != null
          ? promoExpiresAt!.difference(promoUsedAt!).inDays
          : 0;

  int? get daysRemaining {
    if (promoExpiresAt == null) return null;
    return promoExpiresAt!.difference(DateTime.now()).inDays;
  }
}
