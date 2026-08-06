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
