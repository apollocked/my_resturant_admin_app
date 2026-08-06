class PromoCodeSummary {
  final String code;
  final DateTime? createdAt;
  final DateTime? usedAt;
  final DateTime? expiresAt;
  final String? usedByEmail;

  const PromoCodeSummary({
    required this.code,
    this.createdAt,
    this.usedAt,
    this.expiresAt,
    this.usedByEmail,
  });

  factory PromoCodeSummary.fromJson(Map<String, dynamic> row) {
    return PromoCodeSummary(
      code: row['code'] as String? ?? '',
      createdAt: _parseDate(row['created_at']),
      usedAt: _parseDate(row['used_at']),
      expiresAt: _parseDate(row['expires_at']),
      usedByEmail: row['used_by_email'] as String?,
    );
  }

  static DateTime? _parseDate(dynamic v) {
    if (v == null) return null;
    return DateTime.tryParse(v.toString());
  }

  bool get isUsed => usedAt != null || usedByEmail != null;

  bool get isExpired =>
      !isUsed && expiresAt != null && expiresAt!.isBefore(DateTime.now());

  int? get activationDays =>
      usedAt != null && expiresAt != null
          ? expiresAt!.difference(usedAt!).inDays
          : null;
}
