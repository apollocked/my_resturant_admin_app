import 'package:flutter/material.dart';

String formatDate(DateTime? d) {
  if (d == null) return '-';
  final l = d.toLocal();
  return '${l.day}/${l.month}/${l.year}';
}

String formatDateShort(DateTime? d) {
  if (d == null) return '-';
  final l = d.toLocal();
  return '${l.day} ${_monthName(l.month)} ${l.year}';
}

String _monthName(int m) {
  const names = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return names[m - 1];
}

String pluralDays(int days) => '$days day${days == 1 ? '' : 's'}';

String avatarInitials(String email) {
  final local = email.split('@').first;
  if (local.isEmpty) return '?';
  final parts = local.replaceAll(RegExp(r'[^a-zA-Z0-9]'), ' ').trim().split(RegExp(r'\s+'));
  if (parts.isEmpty || parts.first.isEmpty) return email.substring(0, 1).toUpperCase();
  final first = parts.first[0];
  if (parts.length > 1) return (first + parts[1][0]).toUpperCase();
  return first.toUpperCase();
}

Color chipBackground(ColorScheme cs, Color color) => color.withValues(alpha: 0.12);

Color colorForEmail(String email) {
  const palette = [
    Color(0xFF2E7D32),
    Color(0xFF1565C0),
    Color(0xFF6A1B9A),
    Color(0xFFAD1457),
    Color(0xFFE65100),
    Color(0xFF00695C),
    Color(0xFF4527A0),
    Color(0xFF283593),
  ];
  final h = email.hashCode.abs();
  return palette[h % palette.length];
}
