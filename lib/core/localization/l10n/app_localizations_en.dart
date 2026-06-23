// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'LocalAI';

  @override
  String get tabHome => 'Home';

  @override
  String get tabDiscover => 'Discover';

  @override
  String get tabChat => 'Chat';

  @override
  String get tabFavorites => 'Favorites';

  @override
  String get tabProfile => 'Profile';

  @override
  String homeGreeting(String timeOfDay) {
    return 'Good $timeOfDay!';
  }

  @override
  String get homeFindPlace => 'Find the perfect place';

  @override
  String get homeCategoriesTitle => 'Browse by Category';

  @override
  String get homeFeaturedTitle => 'Popular Near You';

  @override
  String get homeStartChat => 'Ask AI for Recommendations';

  @override
  String get categoryRestaurants => 'Restaurants';

  @override
  String get categoryCafes => 'Cafés';

  @override
  String get categoryStores => 'Stores';

  @override
  String get categoryFastFood => 'Fast Food';

  @override
  String get categoryBakeries => 'Bakeries';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryAll => 'All Places';

  @override
  String get discoverTitle => 'Discover';

  @override
  String get discoverSearch => 'Search places...';

  @override
  String get discoverFilter => 'Filter';

  @override
  String get discoverSort => 'Sort';

  @override
  String get discoverNoResults => 'No places found';

  @override
  String get discoverNoResultsHint => 'Try adjusting your search or filters';

  @override
  String get sortByDistance => 'Distance';

  @override
  String get sortByRating => 'Rating';

  @override
  String get sortByName => 'Name';

  @override
  String get sortByNewest => 'Newest';

  @override
  String get filterTitle => 'Filter Places';

  @override
  String get filterCategory => 'Category';

  @override
  String get filterDistance => 'Distance';

  @override
  String get filterRating => 'Minimum Rating';

  @override
  String get filterOpenNow => 'Open Now';

  @override
  String get filterPriceRange => 'Price Range';

  @override
  String get filterApply => 'Apply Filters';

  @override
  String get filterReset => 'Reset';

  @override
  String get placeDetailTitle => 'Place Details';

  @override
  String get placeDetailAbout => 'About';

  @override
  String get placeDetailHours => 'Working Hours';

  @override
  String get placeDetailLocation => 'Location';

  @override
  String get placeDetailContact => 'Contact';

  @override
  String get placeDetailMenu => 'Menu';

  @override
  String get placeDetailPhotos => 'Photos';

  @override
  String get placeDetailReviews => 'Reviews';

  @override
  String get placeDetailSocialMedia => 'Social Media';

  @override
  String get placeDetailWhyMatch => 'Why this matches you';

  @override
  String get placeDetailOpen => 'Open Now';

  @override
  String get placeDetailClosed => 'Closed';

  @override
  String placeDetailOpenUntil(String time) {
    return 'Open until $time';
  }

  @override
  String placeDetailDistance(String distance) {
    return '$distance km away';
  }

  @override
  String get placeDetailCall => 'Call';

  @override
  String get placeDetailWebsite => 'Website';

  @override
  String get placeDetailDirections => 'Get Directions';

  @override
  String get placeDetailSaveFavorite => 'Save to Favorites';

  @override
  String get placeDetailRemoveFavorite => 'Remove from Favorites';

  @override
  String get chatTitle => 'AI Assistant';

  @override
  String get chatPlaceholder => 'Ask me to find a place...';

  @override
  String get chatWelcome =>
      'Hi! I\'m here to help you discover amazing places nearby. What are you looking for today?';

  @override
  String get chatWelcomeAr =>
      'مرحباً! أنا هنا لمساعدتك في اكتشاف أماكن رائعة بالقرب منك. ماذا تبحث عنه اليوم؟';

  @override
  String get chatThinking => 'Finding the best matches...';

  @override
  String get chatRecommendations => 'Here are my top picks for you:';

  @override
  String get chatNewChat => 'New Chat';

  @override
  String get chatVoiceStart => 'Tap to speak';

  @override
  String get chatVoiceListening => 'Listening...';

  @override
  String get chatVoiceStop => 'Tap to stop';

  @override
  String get chatSend => 'Send';

  @override
  String get authTitle => 'Sign In';

  @override
  String get authSubtitle =>
      'Sign in to save favorites and personalize your experience';

  @override
  String get authGoogleSignIn => 'Continue with Google';

  @override
  String get authAppleSignIn => 'Continue with Apple';

  @override
  String get authGuestMode => 'Continue as Guest';

  @override
  String get authSignOut => 'Sign Out';

  @override
  String authSignedInAs(String name) {
    return 'Signed in as $name';
  }

  @override
  String get favoritesTitle => 'My Favorites';

  @override
  String get favoritesEmpty => 'No favorites yet';

  @override
  String get favoritesEmptyHint => 'Tap the heart on any place to save it here';

  @override
  String get favoritesLoginRequired => 'Sign in to save favorites';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profileLanguage => 'Language';

  @override
  String profileLastSync(String time) {
    return 'Last synced: $time';
  }

  @override
  String get profileSyncNow => 'Sync Now';

  @override
  String get profileSyncing => 'Syncing...';

  @override
  String get profileSyncSuccess => 'Sync complete';

  @override
  String get profileSyncError => 'Sync failed. Tap to retry.';

  @override
  String get profileAbout => 'About LocalAI';

  @override
  String profileVersion(String version) {
    return 'Version $version';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'App Language';

  @override
  String get settingsLanguageEn => 'English';

  @override
  String get settingsLanguageAr => 'العربية';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get errorNoInternet => 'No internet connection';

  @override
  String get errorNoInternetHint => 'You\'re viewing cached data';

  @override
  String get errorRetry => 'Retry';

  @override
  String get errorEmpty => 'No data available';

  @override
  String get loading => 'Loading...';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get done => 'Done';

  @override
  String get back => 'Back';

  @override
  String get close => 'Close';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get seeAll => 'See All';

  @override
  String kmAway(String distance) {
    return '$distance km';
  }

  @override
  String reviewCount(int count) {
    return '$count reviews';
  }

  @override
  String get timeOfDayMorning => 'morning';

  @override
  String get timeOfDayAfternoon => 'afternoon';

  @override
  String get timeOfDayEvening => 'evening';

  @override
  String get timeOfDayNight => 'night';

  @override
  String get dayMonday => 'Monday';

  @override
  String get dayTuesday => 'Tuesday';

  @override
  String get dayWednesday => 'Wednesday';

  @override
  String get dayThursday => 'Thursday';

  @override
  String get dayFriday => 'Friday';

  @override
  String get daySaturday => 'Saturday';

  @override
  String get daySunday => 'Sunday';
}
