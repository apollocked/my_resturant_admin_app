// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My Rest Admin';

  @override
  String get appSubtitle => 'Platform control center';

  @override
  String get login_emailLabel => 'Email';

  @override
  String get login_passwordLabel => 'Password';

  @override
  String get login_invalidEmail => 'Enter a valid email';

  @override
  String get login_passwordTooShort => 'Password too short';

  @override
  String get login_unauthorized =>
      'This account is not authorized as platform admin.';

  @override
  String get login_signInFailed => 'Sign in failed. Check your credentials.';

  @override
  String get login_signIn => 'Sign in';

  @override
  String get signOutQuestion => 'Sign out?';

  @override
  String get signOutMessage =>
      'Are you sure you want to sign out of My Rest Admin?';

  @override
  String get signOut => 'Sign out';

  @override
  String get exitQuestion => 'Exit My Rest Admin?';

  @override
  String get exitMessage => 'Are you sure you want to close the app?';

  @override
  String get exit => 'Exit';

  @override
  String get accessDenied => 'Access denied';

  @override
  String get accessDeniedMessage => 'Only the platform admin can use this app.';

  @override
  String get tabRestaurants => 'Restaurants';

  @override
  String get tabPromoCodes => 'Promo Codes';

  @override
  String get tabReports => 'Reports';

  @override
  String get restaurantsTitle => 'Restaurants';

  @override
  String registeredAccounts(int count) {
    return 'Registered accounts: $count';
  }

  @override
  String get statTotal => 'Total';

  @override
  String get statActivated => 'Activated';

  @override
  String get statActiveSubs => 'Active subs';

  @override
  String get statExpiring => 'Expiring ≤30d';

  @override
  String get searchByEmail => 'Search by email…';

  @override
  String get noRestaurantsYet => 'No restaurants yet';

  @override
  String get noMatches => 'No matches';

  @override
  String get noRestaurantsSubtitle =>
      'Tap \"Add restaurant\" to create the first one.';

  @override
  String get noMatchesSubtitle => 'Try a different search.';

  @override
  String get addRestaurant => 'Add restaurant';

  @override
  String get statusNotActivated => 'Not activated';

  @override
  String get statusExpired => 'Expired';

  @override
  String get statusActivated => 'Activated';

  @override
  String joinedOn(Object date) {
    return 'Joined $date';
  }

  @override
  String get recipes => 'recipes';

  @override
  String get orders => 'orders';

  @override
  String get noPromoCodeClaimed => 'No promo code claimed yet';

  @override
  String activationDaysLabel(int days) {
    return 'Activation  •  $days days';
  }

  @override
  String daysLeft(int days) {
    return 'Days left: $days';
  }

  @override
  String codeRange(Object code, Object end, Object start) {
    return 'Code $code  •  $start  →  $end';
  }

  @override
  String get staffPins => 'Staff PINs:';

  @override
  String get roleAdmin => 'Admin';

  @override
  String get roleWaiter => 'Waiter';

  @override
  String get roleKitchen => 'Kitchen';

  @override
  String pinSet(Object role) {
    return '$role PIN set';
  }

  @override
  String pinUnset(Object role) {
    return '$role PIN —';
  }

  @override
  String get promoCodesTitle => 'Promo Codes';

  @override
  String codesMinted(int count) {
    return 'Codes minted: $count';
  }

  @override
  String get addCode => 'Add code';

  @override
  String get filterAll => 'All';

  @override
  String get filterUsed => 'Used';

  @override
  String get filterAvailable => 'Available';

  @override
  String get filterExpired => 'Expired';

  @override
  String get noPromoCodesYet => 'No promo codes yet';

  @override
  String get nothingHere => 'Nothing here';

  @override
  String get noPromoCodesSubtitle => 'Tap \"Add code\" to mint the first one.';

  @override
  String get noFilterSubtitle => 'Try a different filter.';

  @override
  String get statusUsed => 'Used';

  @override
  String get statusAvailable => 'Available';

  @override
  String claimedBy(Object email) {
    return 'Claimed by $email';
  }

  @override
  String activationDurationDays(int days) {
    return 'Activation duration: $days days';
  }

  @override
  String createdOn(Object date) {
    return 'Created $date';
  }

  @override
  String usedOn(Object date) {
    return 'used $date';
  }

  @override
  String expiresOn(Object date) {
    return 'expires $date';
  }

  @override
  String get copy => 'Copy';

  @override
  String get retry => 'Retry';

  @override
  String get failedToLoadRestaurants => 'Failed to load restaurants';

  @override
  String get failedToLoadPromoCodes => 'Failed to load promo codes';

  @override
  String get restaurantCreated => 'Restaurant created.';

  @override
  String restaurantCreatedWithCode(Object code) {
    return 'Restaurant created. Promo code: $code';
  }

  @override
  String get codeCopied => 'Code copied';

  @override
  String promoCodeMinted(Object code) {
    return 'Promo code $code minted.';
  }

  @override
  String get claimedByUnknown => 'Claimed by —';

  @override
  String get reportsTitle => 'Reports';

  @override
  String updatedOn(Object date) {
    return 'Updated $date';
  }

  @override
  String get failedToLoadReports => 'Failed to load reports';

  @override
  String get revenue => 'Revenue';

  @override
  String get itemsSold => 'Items sold';

  @override
  String get perRestaurant => 'Per restaurant';

  @override
  String get noRestaurantAccounts => 'No restaurant accounts yet.';

  @override
  String get accountsAndPromoCodes => 'Accounts & promo codes';

  @override
  String get ordersByStatus => 'Orders by status';

  @override
  String totalCount(int count) {
    return 'Total: $count';
  }

  @override
  String get noOrdersYet => 'No orders yet.';

  @override
  String get statusServed => 'Served';

  @override
  String get statusPreparing => 'Preparing';

  @override
  String get statusPending => 'Pending';

  @override
  String get ordersLast14Days => 'Orders — last 14 days';

  @override
  String get topSellingItems => 'Top selling items';

  @override
  String get accounts => 'Accounts';

  @override
  String get joinedLast30d => 'Joined last 30d';

  @override
  String get joinedLast90d => 'Joined last 90d';

  @override
  String get promoCodes => 'Promo codes';

  @override
  String get expiringIn30d => 'Expiring in 30d';

  @override
  String get statusActive => 'Active';

  @override
  String get codeWord => 'code';

  @override
  String get avgOrder => 'Avg order';

  @override
  String get items => 'Items';

  @override
  String get adminPin => 'Admin PIN';

  @override
  String get waiterPin => 'Waiter PIN';

  @override
  String get kitchenPin => 'Kitchen PIN';

  @override
  String get noPin => 'No PIN';

  @override
  String get createRestaurantQuestion => 'Create restaurant?';

  @override
  String get createRestaurantMessage =>
      'This will create a new restaurant account with access to the platform.';

  @override
  String get create => 'Create';

  @override
  String get somethingWentWrong => 'Something went wrong.';

  @override
  String get addRestaurantSheetTitle => 'Add restaurant';

  @override
  String get addRestaurantSheetSubtitle =>
      'Creates the account directly. Choosing a duration mints & claims a promo code.';

  @override
  String get restaurantEmail => 'Restaurant email';

  @override
  String get passwordTooShortMin6 => 'Password too short (min 6)';

  @override
  String get activationDuration => 'Activation duration';

  @override
  String get mintsPromoCode => 'mints a promo code';

  @override
  String durationMonths(int months) {
    return '$months mo';
  }

  @override
  String get cancel => 'Cancel';

  @override
  String get mintCode => 'Mint code';

  @override
  String get addPromoCodeSheetTitle => 'Add promo code';

  @override
  String get addPromoCodeSheetSubtitle =>
      'Mints a code that restaurants can claim for activation.';

  @override
  String get customCodeOptional => 'Custom code (optional)';

  @override
  String get min4Characters => 'Min 4 characters';

  @override
  String get autoGenerateHint => 'Leave empty to auto-generate a random code.';

  @override
  String get backOnline => 'Back online';

  @override
  String get noInternetConnection => 'No internet connection';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKurdish => 'Kurdî';

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';
}
