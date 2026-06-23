import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
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
/// import 'l10n/app_localizations.dart';
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
    Locale('ar'),
    Locale('en')
  ];

  /// The app name
  ///
  /// In en, this message translates to:
  /// **'LocalAI'**
  String get appName;

  /// No description provided for @tabHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get tabHome;

  /// No description provided for @tabDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get tabDiscover;

  /// No description provided for @tabChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get tabChat;

  /// No description provided for @tabFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get tabFavorites;

  /// No description provided for @tabProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get tabProfile;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good {timeOfDay}!'**
  String homeGreeting(String timeOfDay);

  /// No description provided for @homeFindPlace.
  ///
  /// In en, this message translates to:
  /// **'Find the perfect place'**
  String get homeFindPlace;

  /// No description provided for @homeCategoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Browse by Category'**
  String get homeCategoriesTitle;

  /// No description provided for @homeFeaturedTitle.
  ///
  /// In en, this message translates to:
  /// **'Popular Near You'**
  String get homeFeaturedTitle;

  /// No description provided for @homeStartChat.
  ///
  /// In en, this message translates to:
  /// **'Ask AI for Recommendations'**
  String get homeStartChat;

  /// No description provided for @categoryRestaurants.
  ///
  /// In en, this message translates to:
  /// **'Restaurants'**
  String get categoryRestaurants;

  /// No description provided for @categoryCafes.
  ///
  /// In en, this message translates to:
  /// **'Cafés'**
  String get categoryCafes;

  /// No description provided for @categoryStores.
  ///
  /// In en, this message translates to:
  /// **'Stores'**
  String get categoryStores;

  /// No description provided for @categoryFastFood.
  ///
  /// In en, this message translates to:
  /// **'Fast Food'**
  String get categoryFastFood;

  /// No description provided for @categoryBakeries.
  ///
  /// In en, this message translates to:
  /// **'Bakeries'**
  String get categoryBakeries;

  /// No description provided for @categoryShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get categoryShopping;

  /// No description provided for @categoryAll.
  ///
  /// In en, this message translates to:
  /// **'All Places'**
  String get categoryAll;

  /// No description provided for @discoverTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discoverTitle;

  /// No description provided for @discoverSearch.
  ///
  /// In en, this message translates to:
  /// **'Search places...'**
  String get discoverSearch;

  /// No description provided for @discoverFilter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get discoverFilter;

  /// No description provided for @discoverSort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get discoverSort;

  /// No description provided for @discoverNoResults.
  ///
  /// In en, this message translates to:
  /// **'No places found'**
  String get discoverNoResults;

  /// No description provided for @discoverNoResultsHint.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search or filters'**
  String get discoverNoResultsHint;

  /// No description provided for @sortByDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get sortByDistance;

  /// No description provided for @sortByRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get sortByRating;

  /// No description provided for @sortByName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get sortByName;

  /// No description provided for @sortByNewest.
  ///
  /// In en, this message translates to:
  /// **'Newest'**
  String get sortByNewest;

  /// No description provided for @filterTitle.
  ///
  /// In en, this message translates to:
  /// **'Filter Places'**
  String get filterTitle;

  /// No description provided for @filterCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get filterCategory;

  /// No description provided for @filterDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get filterDistance;

  /// No description provided for @filterRating.
  ///
  /// In en, this message translates to:
  /// **'Minimum Rating'**
  String get filterRating;

  /// No description provided for @filterOpenNow.
  ///
  /// In en, this message translates to:
  /// **'Open Now'**
  String get filterOpenNow;

  /// No description provided for @filterPriceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get filterPriceRange;

  /// No description provided for @filterApply.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get filterApply;

  /// No description provided for @filterReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get filterReset;

  /// No description provided for @placeDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Place Details'**
  String get placeDetailTitle;

  /// No description provided for @placeDetailAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get placeDetailAbout;

  /// No description provided for @placeDetailHours.
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get placeDetailHours;

  /// No description provided for @placeDetailLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get placeDetailLocation;

  /// No description provided for @placeDetailContact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get placeDetailContact;

  /// No description provided for @placeDetailMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get placeDetailMenu;

  /// No description provided for @placeDetailPhotos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get placeDetailPhotos;

  /// No description provided for @placeDetailReviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get placeDetailReviews;

  /// No description provided for @placeDetailSocialMedia.
  ///
  /// In en, this message translates to:
  /// **'Social Media'**
  String get placeDetailSocialMedia;

  /// No description provided for @placeDetailWhyMatch.
  ///
  /// In en, this message translates to:
  /// **'Why this matches you'**
  String get placeDetailWhyMatch;

  /// No description provided for @placeDetailOpen.
  ///
  /// In en, this message translates to:
  /// **'Open Now'**
  String get placeDetailOpen;

  /// No description provided for @placeDetailClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get placeDetailClosed;

  /// No description provided for @placeDetailOpenUntil.
  ///
  /// In en, this message translates to:
  /// **'Open until {time}'**
  String placeDetailOpenUntil(String time);

  /// No description provided for @placeDetailDistance.
  ///
  /// In en, this message translates to:
  /// **'{distance} km away'**
  String placeDetailDistance(String distance);

  /// No description provided for @placeDetailCall.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get placeDetailCall;

  /// No description provided for @placeDetailWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get placeDetailWebsite;

  /// No description provided for @placeDetailDirections.
  ///
  /// In en, this message translates to:
  /// **'Get Directions'**
  String get placeDetailDirections;

  /// No description provided for @placeDetailSaveFavorite.
  ///
  /// In en, this message translates to:
  /// **'Save to Favorites'**
  String get placeDetailSaveFavorite;

  /// No description provided for @placeDetailRemoveFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove from Favorites'**
  String get placeDetailRemoveFavorite;

  /// No description provided for @chatTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Assistant'**
  String get chatTitle;

  /// No description provided for @chatPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Ask me to find a place...'**
  String get chatPlaceholder;

  /// No description provided for @chatWelcome.
  ///
  /// In en, this message translates to:
  /// **'Hi! I\'m here to help you discover amazing places nearby. What are you looking for today?'**
  String get chatWelcome;

  /// No description provided for @chatWelcomeAr.
  ///
  /// In en, this message translates to:
  /// **'مرحباً! أنا هنا لمساعدتك في اكتشاف أماكن رائعة بالقرب منك. ماذا تبحث عنه اليوم؟'**
  String get chatWelcomeAr;

  /// No description provided for @chatThinking.
  ///
  /// In en, this message translates to:
  /// **'Finding the best matches...'**
  String get chatThinking;

  /// No description provided for @chatRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Here are my top picks for you:'**
  String get chatRecommendations;

  /// No description provided for @chatNewChat.
  ///
  /// In en, this message translates to:
  /// **'New Chat'**
  String get chatNewChat;

  /// No description provided for @chatVoiceStart.
  ///
  /// In en, this message translates to:
  /// **'Tap to speak'**
  String get chatVoiceStart;

  /// No description provided for @chatVoiceListening.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get chatVoiceListening;

  /// No description provided for @chatVoiceStop.
  ///
  /// In en, this message translates to:
  /// **'Tap to stop'**
  String get chatVoiceStop;

  /// No description provided for @chatSend.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get chatSend;

  /// No description provided for @authTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get authTitle;

  /// No description provided for @authSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save favorites and personalize your experience'**
  String get authSubtitle;

  /// No description provided for @authGoogleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get authGoogleSignIn;

  /// No description provided for @authAppleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get authAppleSignIn;

  /// No description provided for @authGuestMode.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get authGuestMode;

  /// No description provided for @authSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get authSignOut;

  /// No description provided for @authSignedInAs.
  ///
  /// In en, this message translates to:
  /// **'Signed in as {name}'**
  String authSignedInAs(String name);

  /// No description provided for @favoritesTitle.
  ///
  /// In en, this message translates to:
  /// **'My Favorites'**
  String get favoritesTitle;

  /// No description provided for @favoritesEmpty.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get favoritesEmpty;

  /// No description provided for @favoritesEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart on any place to save it here'**
  String get favoritesEmptyHint;

  /// No description provided for @favoritesLoginRequired.
  ///
  /// In en, this message translates to:
  /// **'Sign in to save favorites'**
  String get favoritesLoginRequired;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// No description provided for @profileLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profileLanguage;

  /// No description provided for @profileLastSync.
  ///
  /// In en, this message translates to:
  /// **'Last synced: {time}'**
  String profileLastSync(String time);

  /// No description provided for @profileSyncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get profileSyncNow;

  /// No description provided for @profileSyncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get profileSyncing;

  /// No description provided for @profileSyncSuccess.
  ///
  /// In en, this message translates to:
  /// **'Sync complete'**
  String get profileSyncSuccess;

  /// No description provided for @profileSyncError.
  ///
  /// In en, this message translates to:
  /// **'Sync failed. Tap to retry.'**
  String get profileSyncError;

  /// No description provided for @profileAbout.
  ///
  /// In en, this message translates to:
  /// **'About LocalAI'**
  String get profileAbout;

  /// No description provided for @profileVersion.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String profileVersion(String version);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'App Language'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEn;

  /// No description provided for @settingsLanguageAr.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get settingsLanguageAr;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @errorNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get errorNoInternet;

  /// No description provided for @errorNoInternetHint.
  ///
  /// In en, this message translates to:
  /// **'You\'re viewing cached data'**
  String get errorNoInternetHint;

  /// No description provided for @errorRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get errorRetry;

  /// No description provided for @errorEmpty.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get errorEmpty;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @kmAway.
  ///
  /// In en, this message translates to:
  /// **'{distance} km'**
  String kmAway(String distance);

  /// No description provided for @reviewCount.
  ///
  /// In en, this message translates to:
  /// **'{count} reviews'**
  String reviewCount(int count);

  /// No description provided for @timeOfDayMorning.
  ///
  /// In en, this message translates to:
  /// **'morning'**
  String get timeOfDayMorning;

  /// No description provided for @timeOfDayAfternoon.
  ///
  /// In en, this message translates to:
  /// **'afternoon'**
  String get timeOfDayAfternoon;

  /// No description provided for @timeOfDayEvening.
  ///
  /// In en, this message translates to:
  /// **'evening'**
  String get timeOfDayEvening;

  /// No description provided for @timeOfDayNight.
  ///
  /// In en, this message translates to:
  /// **'night'**
  String get timeOfDayNight;

  /// No description provided for @dayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get dayMonday;

  /// No description provided for @dayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get dayTuesday;

  /// No description provided for @dayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get dayWednesday;

  /// No description provided for @dayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get dayThursday;

  /// No description provided for @dayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get dayFriday;

  /// No description provided for @daySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get daySaturday;

  /// No description provided for @daySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get daySunday;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
