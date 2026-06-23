// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'لوكال AI';

  @override
  String get tabHome => 'الرئيسية';

  @override
  String get tabDiscover => 'اكتشف';

  @override
  String get tabChat => 'المحادثة';

  @override
  String get tabFavorites => 'المفضلة';

  @override
  String get tabProfile => 'الملف الشخصي';

  @override
  String homeGreeting(String timeOfDay) {
    return 'صباح الخير!';
  }

  @override
  String get homeFindPlace => 'اعثر على المكان المثالي';

  @override
  String get homeCategoriesTitle => 'تصفح حسب الفئة';

  @override
  String get homeFeaturedTitle => 'الأماكن الشهيرة قربك';

  @override
  String get homeStartChat => 'اطلب توصيات من الذكاء الاصطناعي';

  @override
  String get categoryRestaurants => 'مطاعم';

  @override
  String get categoryCafes => 'مقاهي';

  @override
  String get categoryStores => 'متاجر';

  @override
  String get categoryFastFood => 'وجبات سريعة';

  @override
  String get categoryBakeries => 'مخابز';

  @override
  String get categoryShopping => 'تسوق';

  @override
  String get categoryAll => 'جميع الأماكن';

  @override
  String get discoverTitle => 'اكتشف';

  @override
  String get discoverSearch => 'ابحث عن أماكن...';

  @override
  String get discoverFilter => 'تصفية';

  @override
  String get discoverSort => 'ترتيب';

  @override
  String get discoverNoResults => 'لا توجد أماكن';

  @override
  String get discoverNoResultsHint => 'جرب تعديل بحثك أو الفلاتر';

  @override
  String get sortByDistance => 'المسافة';

  @override
  String get sortByRating => 'التقييم';

  @override
  String get sortByName => 'الاسم';

  @override
  String get sortByNewest => 'الأحدث';

  @override
  String get filterTitle => 'تصفية الأماكن';

  @override
  String get filterCategory => 'الفئة';

  @override
  String get filterDistance => 'المسافة';

  @override
  String get filterRating => 'الحد الأدنى للتقييم';

  @override
  String get filterOpenNow => 'مفتوح الآن';

  @override
  String get filterPriceRange => 'نطاق السعر';

  @override
  String get filterApply => 'تطبيق الفلاتر';

  @override
  String get filterReset => 'إعادة تعيين';

  @override
  String get placeDetailTitle => 'تفاصيل المكان';

  @override
  String get placeDetailAbout => 'عن المكان';

  @override
  String get placeDetailHours => 'ساعات العمل';

  @override
  String get placeDetailLocation => 'الموقع';

  @override
  String get placeDetailContact => 'التواصل';

  @override
  String get placeDetailMenu => 'القائمة';

  @override
  String get placeDetailPhotos => 'الصور';

  @override
  String get placeDetailReviews => 'التقييمات';

  @override
  String get placeDetailSocialMedia => 'التواصل الاجتماعي';

  @override
  String get placeDetailWhyMatch => 'لماذا يناسبك هذا المكان';

  @override
  String get placeDetailOpen => 'مفتوح الآن';

  @override
  String get placeDetailClosed => 'مغلق';

  @override
  String placeDetailOpenUntil(String time) {
    return 'مفتوح حتى $time';
  }

  @override
  String placeDetailDistance(String distance) {
    return 'على بعد $distance كم';
  }

  @override
  String get placeDetailCall => 'اتصال';

  @override
  String get placeDetailWebsite => 'الموقع الإلكتروني';

  @override
  String get placeDetailDirections => 'الحصول على الاتجاهات';

  @override
  String get placeDetailSaveFavorite => 'حفظ في المفضلة';

  @override
  String get placeDetailRemoveFavorite => 'إزالة من المفضلة';

  @override
  String get chatTitle => 'المساعد الذكي';

  @override
  String get chatPlaceholder => 'اسألني لأجد لك مكاناً...';

  @override
  String get chatWelcome =>
      'مرحباً! أنا هنا لمساعدتك في اكتشاف أماكن رائعة بالقرب منك. ماذا تبحث عنه اليوم؟';

  @override
  String get chatWelcomeAr =>
      'مرحباً! أنا هنا لمساعدتك في اكتشاف أماكن رائعة بالقرب منك. ماذا تبحث عنه اليوم؟';

  @override
  String get chatThinking => 'أبحث عن أفضل الخيارات...';

  @override
  String get chatRecommendations => 'إليك أفضل اقتراحاتي لك:';

  @override
  String get chatNewChat => 'محادثة جديدة';

  @override
  String get chatVoiceStart => 'اضغط للتحدث';

  @override
  String get chatVoiceListening => 'جارٍ الاستماع...';

  @override
  String get chatVoiceStop => 'اضغط للإيقاف';

  @override
  String get chatSend => 'إرسال';

  @override
  String get authTitle => 'تسجيل الدخول';

  @override
  String get authSubtitle => 'سجّل دخولك لحفظ المفضلة وتخصيص تجربتك';

  @override
  String get authGoogleSignIn => 'المتابعة مع Google';

  @override
  String get authAppleSignIn => 'المتابعة مع Apple';

  @override
  String get authGuestMode => 'المتابعة كضيف';

  @override
  String get authSignOut => 'تسجيل الخروج';

  @override
  String authSignedInAs(String name) {
    return 'مسجّل الدخول بحساب $name';
  }

  @override
  String get favoritesTitle => 'المفضلة';

  @override
  String get favoritesEmpty => 'لا توجد مفضلات بعد';

  @override
  String get favoritesEmptyHint => 'اضغط على القلب في أي مكان لحفظه هنا';

  @override
  String get favoritesLoginRequired => 'سجّل دخولك لحفظ المفضلة';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String get profileSettings => 'الإعدادات';

  @override
  String get profileLanguage => 'اللغة';

  @override
  String profileLastSync(String time) {
    return 'آخر مزامنة: $time';
  }

  @override
  String get profileSyncNow => 'مزامنة الآن';

  @override
  String get profileSyncing => 'جارٍ المزامنة...';

  @override
  String get profileSyncSuccess => 'اكتملت المزامنة';

  @override
  String get profileSyncError => 'فشلت المزامنة. اضغط للمحاولة مجدداً.';

  @override
  String get profileAbout => 'عن LocalAI';

  @override
  String profileVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsLanguage => 'لغة التطبيق';

  @override
  String get settingsLanguageEn => 'English';

  @override
  String get settingsLanguageAr => 'العربية';

  @override
  String get errorGeneric => 'حدث خطأ ما. يرجى المحاولة مجدداً.';

  @override
  String get errorNoInternet => 'لا يوجد اتصال بالإنترنت';

  @override
  String get errorNoInternetHint => 'تعرض البيانات المخزنة مؤقتاً';

  @override
  String get errorRetry => 'إعادة المحاولة';

  @override
  String get errorEmpty => 'لا تتوفر بيانات';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get done => 'تم';

  @override
  String get back => 'رجوع';

  @override
  String get close => 'إغلاق';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String kmAway(String distance) {
    return '$distance كم';
  }

  @override
  String reviewCount(int count) {
    return '$count تقييم';
  }

  @override
  String get timeOfDayMorning => 'الصباح';

  @override
  String get timeOfDayAfternoon => 'الظهيرة';

  @override
  String get timeOfDayEvening => 'المساء';

  @override
  String get timeOfDayNight => 'الليل';

  @override
  String get dayMonday => 'الاثنين';

  @override
  String get dayTuesday => 'الثلاثاء';

  @override
  String get dayWednesday => 'الأربعاء';

  @override
  String get dayThursday => 'الخميس';

  @override
  String get dayFriday => 'الجمعة';

  @override
  String get daySaturday => 'السبت';

  @override
  String get daySunday => 'الأحد';
}
