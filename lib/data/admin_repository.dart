import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/promo_code_summary.dart';
import '../models/restaurant_summary.dart';

class AdminRepository {
  SupabaseClient get _client => Supabase.instance.client;

  Future<bool> isAdmin() async {
    try {
      final result = await _client.rpc('is_admin');
      return result == true;
    } catch (_) {
      return false;
    }
  }

  Future<List<RestaurantSummary>> listRestaurants() async {
    final data = await _client.rpc('admin_list_restaurants');
    final rows = data as List? ?? const [];
    return rows
        .map((e) => RestaurantSummary.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<PromoCodeSummary>> listPromoCodes() async {
    final data = await _client.rpc('admin_list_promo_codes');
    final rows = data as List? ?? const [];
    return rows
        .map((e) => PromoCodeSummary.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Creates a restaurant account directly. Returns the generated promo
  /// code, or null when no activation duration was given.
  Future<String?> createRestaurant({
    required String email,
    required String password,
    int durationMonths = 0,
  }) async {
    final code = await _client.rpc('admin_create_restaurant', params: {
      'p_email': email,
      'p_password': password,
      'p_duration_months': durationMonths,
    });
    return code as String?;
  }

  Future<void> signOut() => _client.auth.signOut();
}
