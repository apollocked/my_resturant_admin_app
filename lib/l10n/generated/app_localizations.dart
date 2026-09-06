import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ckb.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ckb'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'My Rest Admin'**
  String get appTitle;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Platform control center'**
  String get appSubtitle;

  /// No description provided for @login_emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get login_emailLabel;

  /// No description provided for @login_passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_passwordLabel;

  /// No description provided for @login_invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get login_invalidEmail;

  /// No description provided for @login_passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password too short'**
  String get login_passwordTooShort;

  /// No description provided for @login_unauthorized.
  ///
  /// In en, this message translates to:
  /// **'This account is not authorized as platform admin.'**
  String get login_unauthorized;

  /// No description provided for @login_signInFailed.
  ///
  /// In en, this message translates to:
  /// **'Sign in failed. Check your credentials.'**
  String get login_signInFailed;

  /// No description provided for @login_signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get login_signIn;

  /// No description provided for @signOutQuestion.
  ///
  /// In en, this message translates to:
  /// **'Sign out?'**
  String get signOutQuestion;

  /// No description provided for @signOutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out of My Rest Admin?'**
  String get signOutMessage;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @exitQuestion.
  ///
  /// In en, this message translates to:
  /// **'Exit My Rest Admin?'**
  String get exitQuestion;

  /// No description provided for @exitMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to close the app?'**
  String get exitMessage;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @accessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access denied'**
  String get accessDenied;

  /// No description provided for @accessDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Only the platform admin can use this app.'**
  String get accessDeniedMessage;

  /// No description provided for @tabRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get tabRestaurants;

  /// No description provided for @tabPromoCodes.
  ///
  /// In en, this message translates to:
  /// **'Promo Codes'**
  String get tabPromoCodes;

  /// No description provided for @tabReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get tabReports;

  /// No description provided for @restaurantsTitle.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get restaurantsTitle;

  /// No description provided for @registeredAccounts.
  ///
  /// In en, this message translates to:
  /// **'Registered accounts: {count}'**
  String registeredAccounts(int count);

  /// No description provided for @statTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get statTotal;

  /// No description provided for @statActivated.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get statActivated;

  /// No description provided for @statActiveSubs.
  ///
  /// In en, this message translates to:
  /// **'Active subs'**
  String get statActiveSubs;

  /// No description provided for @statExpiring.
  ///
  /// In en, this message translates to:
  /// **'Expiring ≤30d'**
  String get statExpiring;

  /// No description provided for @searchByEmail.
  ///
  /// In en, this message translates to:
  /// **'Search by email…'**
  String get searchByEmail;

  /// No description provided for @noRestaurantsYet.
  ///
  /// In en, this message translates to:
  /// **'No restaurants yet'**
  String get noRestaurantsYet;

  /// No description provided for @noMatches.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get noMatches;

  /// No description provided for @noRestaurantsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Add restaurant\" to create the first one.'**
  String get noRestaurantsSubtitle;

  /// No description provided for @noMatchesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Try a different search.'**
  String get noMatchesSubtitle;

  /// No description provided for @addRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Add restaurant'**
  String get addRestaurant;

  /// No description provided for @statusNotActivated.
  ///
  /// In en, this message translates to:
  /// **'Not activated'**
  String get statusNotActivated;

  /// No description provided for @statusExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get statusExpired;

  /// No description provided for @statusActivated.
  ///
  /// In en, this message translates to:
  /// **'Activated'**
  String get statusActivated;

  /// No description provided for @joinedOn.
  ///
  /// In en, this message translates to:
  /// **'Joined {date}'**
  String joinedOn(Object date);

  /// No description provided for @recipes.
  ///
  /// In en, this message translates to:
  /// **'recipes'**
  String get recipes;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'orders'**
  String get orders;

  /// No description provided for @noPromoCodeClaimed.
  ///
  /// In en, this message translates to:
  /// **'No promo code claimed yet'**
  String get noPromoCodeClaimed;

  /// No description provided for @activationDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Activation  •  {days} days'**
  String activationDaysLabel(int days);

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'Days left: {days}'**
  String daysLeft(int days);

  /// No description provided for @codeRange.
  ///
  /// In en, this message translates to:
  /// **'Code {code}  •  {start}  →  {end}'**
  String codeRange(Object code, Object end, Object start);

  /// No description provided for @staffPins.
  ///
  /// In en, this message translates to:
  /// **'Staff PINs:'**
  String get staffPins;

  /// No description provided for @roleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get roleAdmin;

  /// No description provided for @roleWaiter.
  ///
  /// In en, this message translates to:
  /// **'Waiter'**
  String get roleWaiter;

  /// No description provided for @roleKitchen.
  ///
  /// In en, this message translates to:
  /// **'Kitchen'**
  String get roleKitchen;

  /// No description provided for @pinSet.
  ///
  /// In en, this message translates to:
  /// **'{role} PIN set'**
  String pinSet(Object role);

  /// No description provided for @pinUnset.
  ///
  /// In en, this message translates to:
  /// **'{role} PIN —'**
  String pinUnset(Object role);

  /// No description provided for @promoCodesTitle.
  ///
  /// In en, this message translates to:
  /// **'Promo Codes'**
  String get promoCodesTitle;

  /// No description provided for @codesMinted.
  ///
  /// In en, this message translates to:
  /// **'Codes minted: {count}'**
  String codesMinted(int count);

  /// No description provided for @addCode.
  ///
  /// In en, this message translates to:
  /// **'Add code'**
  String get addCode;

  /// No description provided for @filterAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// No description provided for @filterUsed.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get filterUsed;

  /// No description provided for @filterAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get filterAvailable;

  /// No description provided for @filterExpired.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get filterExpired;

  /// No description provided for @noPromoCodesYet.
  ///
  /// In en, this message translates to:
  /// **'No promo codes yet'**
  String get noPromoCodesYet;

  /// No description provided for @nothingHere.
  ///
  /// In en, this message translates to:
  /// **'Nothing here'**
  String get nothingHere;

  /// No description provided for @noPromoCodesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap \"Add code\" to mint the first one.'**
  String get noPromoCodesSubtitle;

  /// No description provided for @noFilterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Try a different filter.'**
  String get noFilterSubtitle;

  /// No description provided for @statusUsed.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get statusUsed;

  /// No description provided for @statusAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get statusAvailable;

  /// No description provided for @claimedBy.
  ///
  /// In en, this message translates to:
  /// **'Claimed by {email}'**
  String claimedBy(Object email);

  /// No description provided for @activationDurationDays.
  ///
  /// In en, this message translates to:
  /// **'Activation duration: {days} days'**
  String activationDurationDays(int days);

  /// No description provided for @createdOn.
  ///
  /// In en, this message translates to:
  /// **'Created {date}'**
  String createdOn(Object date);

  /// No description provided for @usedOn.
  ///
  /// In en, this message translates to:
  /// **'used {date}'**
  String usedOn(Object date);

  /// No description provided for @expiresOn.
  ///
  /// In en, this message translates to:
  /// **'expires {date}'**
  String expiresOn(Object date);

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @failedToLoadRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Failed to load restaurants'**
  String get failedToLoadRestaurants;

  /// No description provided for @failedToLoadPromoCodes.
  ///
  /// In en, this message translates to:
  /// **'Failed to load promo codes'**
  String get failedToLoadPromoCodes;

  /// No description provided for @restaurantCreated.
  ///
  /// In en, this message translates to:
  /// **'Restaurant created.'**
  String get restaurantCreated;

  /// No description provided for @restaurantCreatedWithCode.
  ///
  /// In en, this message translates to:
  /// **'Restaurant created. Promo code: {code}'**
  String restaurantCreatedWithCode(Object code);

  /// No description provided for @codeCopied.
  ///
  /// In en, this message translates to:
  /// **'Code copied'**
  String get codeCopied;

  /// No description provided for @promoCodeMinted.
  ///
  /// In en, this message translates to:
  /// **'Promo code {code} minted.'**
  String promoCodeMinted(Object code);

  /// No description provided for @claimedByUnknown.
  ///
  /// In en, this message translates to:
  /// **'Claimed by —'**
  String get claimedByUnknown;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsTitle;

  /// No description provided for @updatedOn.
  ///
  /// In en, this message translates to:
  /// **'Updated {date}'**
  String updatedOn(Object date);

  /// No description provided for @failedToLoadReports.
  ///
  /// In en, this message translates to:
  /// **'Failed to load reports'**
  String get failedToLoadReports;

  /// No description provided for @revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// No description provided for @itemsSold.
  ///
  /// In en, this message translates to:
  /// **'Items sold'**
  String get itemsSold;

  /// No description provided for @perRestaurant.
  ///
  /// In en, this message translates to:
  /// **'Per restaurant'**
  String get perRestaurant;

  /// No description provided for @noRestaurantAccounts.
  ///
  /// In en, this message translates to:
  /// **'No restaurant accounts yet.'**
  String get noRestaurantAccounts;

  /// No description provided for @accountsAndPromoCodes.
  ///
  /// In en, this message translates to:
  /// **'Accounts & promo codes'**
  String get accountsAndPromoCodes;

  /// No description provided for @ordersByStatus.
  ///
  /// In en, this message translates to:
  /// **'Orders by status'**
  String get ordersByStatus;

  /// No description provided for @totalCount.
  ///
  /// In en, this message translates to:
  /// **'Total: {count}'**
  String totalCount(int count);

  /// No description provided for @noOrdersYet.
  ///
  /// In en, this message translates to:
  /// **'No orders yet.'**
  String get noOrdersYet;

  /// No description provided for @statusServed.
  ///
  /// In en, this message translates to:
  /// **'Served'**
  String get statusServed;

  /// No description provided for @statusPreparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing'**
  String get statusPreparing;

  /// No description provided for @statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// No description provided for @ordersLast14Days.
  ///
  /// In en, this message translates to:
  /// **'Orders — last 14 days'**
  String get ordersLast14Days;

  /// No description provided for @topSellingItems.
  ///
  /// In en, this message translates to:
  /// **'Top selling items'**
  String get topSellingItems;

  /// No description provided for @accounts.
  ///
  /// In en, this message translates to:
  /// **'Accounts'**
  String get accounts;

  /// No description provided for @joinedLast30d.
  ///
  /// In en, this message translates to:
  /// **'Joined last 30d'**
  String get joinedLast30d;

  /// No description provided for @joinedLast90d.
  ///
  /// In en, this message translates to:
  /// **'Joined last 90d'**
  String get joinedLast90d;

  /// No description provided for @promoCodes.
  ///
  /// In en, this message translates to:
  /// **'Promo codes'**
  String get promoCodes;

  /// No description provided for @expiringIn30d.
  ///
  /// In en, this message translates to:
  /// **'Expiring in 30d'**
  String get expiringIn30d;

  /// No description provided for @statusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get statusActive;

  /// No description provided for @codeWord.
  ///
  /// In en, this message translates to:
  /// **'code'**
  String get codeWord;

  /// No description provided for @avgOrder.
  ///
  /// In en, this message translates to:
  /// **'Avg order'**
  String get avgOrder;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @adminPin.
  ///
  /// In en, this message translates to:
  /// **'Admin PIN'**
  String get adminPin;

  /// No description provided for @waiterPin.
  ///
  /// In en, this message translates to:
  /// **'Waiter PIN'**
  String get waiterPin;

  /// No description provided for @kitchenPin.
  ///
  /// In en, this message translates to:
  /// **'Kitchen PIN'**
  String get kitchenPin;

  /// No description provided for @noPin.
  ///
  /// In en, this message translates to:
  /// **'No PIN'**
  String get noPin;

  /// No description provided for @createRestaurantQuestion.
  ///
  /// In en, this message translates to:
  /// **'Create restaurant?'**
  String get createRestaurantQuestion;

  /// No description provided for @createRestaurantMessage.
  ///
  /// In en, this message translates to:
  /// **'This will create a new restaurant account with access to the platform.'**
  String get createRestaurantMessage;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get somethingWentWrong;

  /// No description provided for @addRestaurantSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add restaurant'**
  String get addRestaurantSheetTitle;

  /// No description provided for @addRestaurantSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Creates the account directly. Choosing a duration mints & claims a promo code.'**
  String get addRestaurantSheetSubtitle;

  /// No description provided for @restaurantEmail.
  ///
  /// In en, this message translates to:
  /// **'Restaurant email'**
  String get restaurantEmail;

  /// No description provided for @passwordTooShortMin6.
  ///
  /// In en, this message translates to:
  /// **'Password too short (min 6)'**
  String get passwordTooShortMin6;

  /// No description provided for @activationDuration.
  ///
  /// In en, this message translates to:
  /// **'Activation duration'**
  String get activationDuration;

  /// No description provided for @mintsPromoCode.
  ///
  /// In en, this message translates to:
  /// **'mints a promo code'**
  String get mintsPromoCode;

  /// No description provided for @durationMonths.
  ///
  /// In en, this message translates to:
  /// **'{months} mo'**
  String durationMonths(int months);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @mintCode.
  ///
  /// In en, this message translates to:
  /// **'Mint code'**
  String get mintCode;

  /// No description provided for @addPromoCodeSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add promo code'**
  String get addPromoCodeSheetTitle;

  /// No description provided for @addPromoCodeSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Mints a code that restaurants can claim for activation.'**
  String get addPromoCodeSheetSubtitle;

  /// No description provided for @customCodeOptional.
  ///
  /// In en, this message translates to:
  /// **'Custom code (optional)'**
  String get customCodeOptional;

  /// No description provided for @min4Characters.
  ///
  /// In en, this message translates to:
  /// **'Min 4 characters'**
  String get min4Characters;

  /// No description provided for @autoGenerateHint.
  ///
  /// In en, this message translates to:
  /// **'Leave empty to auto-generate a random code.'**
  String get autoGenerateHint;

  /// No description provided for @backOnline.
  ///
  /// In en, this message translates to:
  /// **'Back online'**
  String get backOnline;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageKurdish.
  ///
  /// In en, this message translates to:
  /// **'Kurdî'**
  String get languageKurdish;

  /// No description provided for @monthJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get monthDec;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ckb', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ckb':
      return AppLocalizationsCkb();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
