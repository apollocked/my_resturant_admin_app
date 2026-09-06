// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Central Kurdish (`ckb`).
class AppLocalizationsCkb extends AppLocalizations {
  AppLocalizationsCkb([String locale = 'ckb']) : super(locale);

  @override
  String get appTitle => 'My Rest Admin';

  @override
  String get appSubtitle => 'ناوەندی کۆنترۆڵی پلاتفۆرم';

  @override
  String get login_emailLabel => 'ئیمەیڵ';

  @override
  String get login_passwordLabel => 'وشەی نهێنی';

  @override
  String get login_invalidEmail => 'ئیمەیڵێکی دروست بنووسە';

  @override
  String get login_passwordTooShort => 'وشەی نهێنی زۆر کورتە';

  @override
  String get login_unauthorized =>
      'ئەم هەژمارەیە دەسەڵاتی بەڕێوەبەری پلاتفۆرمی نییە.';

  @override
  String get login_signInFailed =>
      'چوونەژوورەوە سەرکەوتوو نەبوو. پشکنینی ڕەچاو بکە.';

  @override
  String get login_signIn => 'چوونە ژوورەوە';

  @override
  String get signOutQuestion => 'دەرچوون؟';

  @override
  String get signOutMessage =>
      'دڵنیایت کە دەتەوێت لە My Rest Admin بچیتە دەرەوە؟';

  @override
  String get signOut => 'دەرچوون';

  @override
  String get exitQuestion => 'داخستنی My Rest Admin؟';

  @override
  String get exitMessage => 'دڵنیایت کە دەتەوێت ئەپەکە ببەیتەوە؟';

  @override
  String get exit => 'داخستن';

  @override
  String get accessDenied => 'ڕێگەپێنەدراوە';

  @override
  String get accessDeniedMessage =>
      'تەنها بەڕێوەبەری پلاتفۆرم دەتوانێت ئەم ئەپە بەکاربهێنێت.';

  @override
  String get tabRestaurants => 'ڕێستۆرانتەکان';

  @override
  String get tabPromoCodes => 'کۆدی پرۆمۆ';

  @override
  String get tabReports => 'ڕاپۆرتەکان';

  @override
  String get restaurantsTitle => 'ڕێستۆرانتەکان';

  @override
  String registeredAccounts(int count) {
    return 'هەژمارە تۆمارکراوەکان: $count';
  }

  @override
  String get statTotal => 'کۆ';

  @override
  String get statActivated => 'چالاککراو';

  @override
  String get statActiveSubs => 'بەشداربووی چالاک';

  @override
  String get statExpiring => 'بەسەرچوون ≤٣٠ ڕۆژ';

  @override
  String get statOrders => 'داوەکان';

  @override
  String get searchByEmail => 'گەڕان بە ئیمەیڵ…';

  @override
  String get noRestaurantsYet => 'هێشتا ڕێستۆرانت نییە';

  @override
  String get noMatches => 'هیچ نەدۆزرایەوە';

  @override
  String get noRestaurantsSubtitle =>
      'کرتە لە \"زیادکردنی ڕێستۆرانت\" بکە بۆ دروستکردنی یەکەم.';

  @override
  String get noMatchesSubtitle => 'گەڕانێکی جیاواز تاقی بکەوە.';

  @override
  String get addRestaurant => 'زیادکردنی ڕێستۆرانت';

  @override
  String get statusNotActivated => 'چالاک نەکراوە';

  @override
  String get statusExpired => 'بەسەرچوو';

  @override
  String get statusActivated => 'چالاککراو';

  @override
  String joinedOn(Object date) {
    return 'لە $date بەشداری کردووە';
  }

  @override
  String get recipes => 'چێشت';

  @override
  String get orders => 'داوەکان';

  @override
  String get noPromoCodeClaimed => 'هێشتا هیچ کۆدێکی پرۆمۆ داوا نەکراوە';

  @override
  String activationDaysLabel(int days) {
    return 'چالاکبوون  •  $days ڕۆژ';
  }

  @override
  String daysLeft(int days) {
    return 'ڕۆژەکانی ماوە: $days';
  }

  @override
  String codeRange(Object code, Object end, Object start) {
    return 'کۆد $code  •  $start  ←  $end';
  }

  @override
  String get staffPins => 'پینەکانی ستاف:';

  @override
  String get roleAdmin => 'بەڕێوەبەر';

  @override
  String get roleWaiter => 'ڕێشەفەر';

  @override
  String get roleKitchen => 'چێشتخانە';

  @override
  String pinSet(Object role) {
    return 'پینی $role دانراوە';
  }

  @override
  String pinUnset(Object role) {
    return 'پینی $role —';
  }

  @override
  String get promoCodesTitle => 'کۆدی پرۆمۆ';

  @override
  String codesMinted(int count) {
    return 'کۆدە دروستکراوەکان: $count';
  }

  @override
  String get addCode => 'زیادکردنی کۆد';

  @override
  String get filterAll => 'هەموو';

  @override
  String get filterUsed => 'بەکارهاتوو';

  @override
  String get filterAvailable => 'بەردەست';

  @override
  String get filterExpired => 'بەسەرچوو';

  @override
  String get noPromoCodesYet => 'هێشتا کۆدی پرۆمۆ نییە';

  @override
  String get nothingHere => 'هیچ شتێک لێرە نییە';

  @override
  String get noPromoCodesSubtitle =>
      'کرتە لە \"زیادکردنی کۆد\" بکە بۆ دروستکردنی یەکەم.';

  @override
  String get noFilterSubtitle => 'فلتەرێکی جیاواز تاقی بکەوە.';

  @override
  String get statusUsed => 'بەکارهاتوو';

  @override
  String get statusAvailable => 'بەردەست';

  @override
  String claimedBy(Object email) {
    return 'داواکراوە لەلایەن $email';
  }

  @override
  String activationDurationDays(int days) {
    return 'ماوەی چالاکبوون: $days ڕۆژ';
  }

  @override
  String createdOn(Object date) {
    return 'دروستکراوە لە $date';
  }

  @override
  String usedOn(Object date) {
    return 'بەکارهاتوو لە $date';
  }

  @override
  String expiresOn(Object date) {
    return 'بەسەردەچێت لە $date';
  }

  @override
  String get copy => 'لەبەرگرتنەوە';

  @override
  String get retry => 'هەوڵدانەوە';

  @override
  String get failedToLoadRestaurants =>
      'بارکردنی ڕێستۆرانتەکان سەرکەوتوو نەبوو';

  @override
  String get failedToLoadPromoCodes => 'بارکردنی کۆدی پرۆمۆ سەرکەوتوو نەبوو';

  @override
  String get restaurantCreated => 'ڕێستۆرانت دروستکرا.';

  @override
  String restaurantCreatedWithCode(Object code) {
    return 'ڕێستۆرانت دروستکرا. کۆدی پرۆمۆ: $code';
  }

  @override
  String get codeCopied => 'کۆدەکە لەبەرگیرایەوە';

  @override
  String promoCodeMinted(Object code) {
    return 'کۆدی پرۆمۆ $code دروستکرا.';
  }

  @override
  String get claimedByUnknown => 'داواکراوە لەلایەن —';

  @override
  String get reportsTitle => 'ڕاپۆرتەکان';

  @override
  String updatedOn(Object date) {
    return 'نوێکراوەتەوە لە $date';
  }

  @override
  String get failedToLoadReports => 'بارکردنی ڕاپۆرتەکان سەرکەوتوو نەبوو';

  @override
  String get revenue => 'داهات';

  @override
  String get itemsSold => 'کاڵا فرۆشراوەکان';

  @override
  String get perRestaurant => 'بۆ هەر ڕێستۆرانت';

  @override
  String get noRestaurantAccounts => 'هێشتا هەژماری ڕێستۆرانت نییە.';

  @override
  String get accountsAndPromoCodes => 'هەژمارەکان و کۆدی پرۆمۆ';

  @override
  String get ordersByStatus => 'داوەکان بەپێی دۆخ';

  @override
  String totalCount(int count) {
    return 'کۆ: $count';
  }

  @override
  String get noOrdersYet => 'هێشتا هیچ داواکارییەک نییە.';

  @override
  String get statusServed => 'خزمەتکراو';

  @override
  String get statusPreparing => 'ئامادەدەکرێت';

  @override
  String get statusPending => 'چاوەڕوان';

  @override
  String get ordersLast14Days => 'داوەکان — ١٤ ڕۆژی ڕابردوو';

  @override
  String get topSellingItems => 'فرۆشترین کاڵاکان';

  @override
  String get accounts => 'هەژمارەکان';

  @override
  String get joinedLast30d => 'بەشداریکردوو لە ٣٠ ڕۆژی ڕابردوودا';

  @override
  String get joinedLast90d => 'بەشداریکردوو لە ٩٠ ڕۆژی ڕابردوودا';

  @override
  String get promoCodes => 'کۆدی پرۆمۆ';

  @override
  String get expiringIn30d => 'بەسەردەچێت لە ٣٠ ڕۆژدا';

  @override
  String get statusActive => 'چالاک';

  @override
  String get codeWord => 'کۆد';

  @override
  String get avgOrder => 'ناوەندی داواکاری';

  @override
  String get items => 'کاڵا';

  @override
  String get adminPin => 'پینی بەڕێوەبەر';

  @override
  String get waiterPin => 'پینی ڕێشەفەر';

  @override
  String get kitchenPin => 'پینی چێشتخانە';

  @override
  String get noPin => 'بێ پین';

  @override
  String get createRestaurantQuestion => 'دروستکردنی ڕێستۆرانت؟';

  @override
  String get createRestaurantMessage =>
      'ئەمە هەژمارەیەکی نوێی ڕێستۆرانت دروست دەکات کە دەستگەیشتنی بە پلاتفۆرم دەبێت.';

  @override
  String get create => 'دروستکردن';

  @override
  String get somethingWentWrong => 'هەڵەیەک ڕوویدا.';

  @override
  String get addRestaurantSheetTitle => 'زیادکردنی ڕێستۆرانت';

  @override
  String get addRestaurantSheetSubtitle =>
      'هەژمارەکە ڕاستەوخۆ دروست دەکات. هەڵبژاردنی ماوەیەک کۆدی پرۆمۆ دروست و داوا دەکات.';

  @override
  String get restaurantEmail => 'ئیمەیڵی ڕێستۆرانت';

  @override
  String get passwordTooShortMin6 => 'وشەی نهێنی زۆر کورتە (بەلایەنی کەم ٦)';

  @override
  String get activationDuration => 'ماوەی چالاکبوون';

  @override
  String get mintsPromoCode => 'کۆدی پرۆمۆ دروست دەکات';

  @override
  String durationMonths(int months) {
    return '$months مانگ';
  }

  @override
  String get cancel => 'پاشگەزبوونەوە';

  @override
  String get mintCode => 'دروستکردنی کۆد';

  @override
  String get addPromoCodeSheetTitle => 'زیادکردنی کۆدی پرۆمۆ';

  @override
  String get addPromoCodeSheetSubtitle =>
      'کۆدێک دروست دەکات کە ڕێستۆرانتەکان دەتوانن بۆ چالاکبوون داوا بکەن.';

  @override
  String get customCodeOptional => 'کۆدی تایبەت (هەڵبژاردەیی)';

  @override
  String get min4Characters => 'بەلایەنی کەم ٤ نووسە';

  @override
  String get autoGenerateHint => 'بەتاڵی بهێڵەوە بۆ دروستکردنی کۆدی هەڕەمەکی.';

  @override
  String get backOnline => 'گەڕانەوە بۆ ئۆنلاین';

  @override
  String get noInternetConnection => 'هیچ پەیوەندییەکی ئینتەرنێت نییە';

  @override
  String get language => 'زمان';

  @override
  String get languageEnglish => 'Englіsh';

  @override
  String get languageKurdish => 'کوردی';

  @override
  String get monthJan => 'کانوونی دووەم';

  @override
  String get monthFeb => 'شوبات';

  @override
  String get monthMar => 'ئازار';

  @override
  String get monthApr => 'نیسان';

  @override
  String get monthMay => 'ئایار';

  @override
  String get monthJun => 'حوزەیران';

  @override
  String get monthJul => 'تەمووز';

  @override
  String get monthAug => 'ئاب';

  @override
  String get monthSep => 'ئەیلوول';

  @override
  String get monthOct => 'تشرینی یەکەم';

  @override
  String get monthNov => 'تشرینی دووەم';

  @override
  String get monthDec => 'کانوونی یەکەم';
}
