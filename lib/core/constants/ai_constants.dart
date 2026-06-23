class AiConstants {
  AiConstants._();

  // MediaPipe model asset path
  static const String modelAssetPath = 'assets/models/gemma-3-1b-it-int4.task';

  // Model config
  static const int maxTokens = 512;
  static const double temperature = 0.7;
  static const int topK = 40;

  // Conversation
  static const String roleUser = 'user';
  static const String roleAssistant = 'assistant';
  static const String roleSystem = 'system';

  // Preference keys (extracted from conversation)
  static const String prefCuisineType = 'cuisine_type';
  static const String prefBudgetLevel = 'budget_level';
  static const String prefMaxDistanceKm = 'max_distance_km';
  static const String prefMealType = 'meal_type';
  static const String prefOpenNow = 'open_now';
  static const String prefExcluded = 'excluded';
  static const String prefKeywords = 'keywords';

  // Meal types
  static const String mealTypeDineIn = 'dine_in';
  static const String mealTypeTakeaway = 'takeaway';
  static const String mealTypeDelivery = 'delivery';

  // Budget levels
  static const int budgetLow = 1;
  static const int budgetMedium = 2;
  static const int budgetHigh = 3;
  static const int budgetLuxury = 4;
}
