import 'package:drift/drift.dart';
import 'connection/shared.dart';
import 'daos/places_dao.dart';
import 'daos/categories_dao.dart';
import 'daos/favorites_dao.dart';
import 'daos/chat_dao.dart';
import 'daos/sync_dao.dart';

part 'app_database.g.dart';

class PlacesTable extends Table {
  @override String get tableName => 'places';
  IntColumn get id => integer()();
  TextColumn get nameAr => text()();
  TextColumn get nameEn => text()();
  TextColumn get descriptionAr => text().withDefault(const Constant(''))();
  TextColumn get descriptionEn => text().withDefault(const Constant(''))();
  TextColumn get addressAr => text().withDefault(const Constant(''))();
  TextColumn get addressEn => text().withDefault(const Constant(''))();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get phone => text().nullable()();
  TextColumn get website => text().nullable()();
  RealColumn get rating => real().withDefault(const Constant(0.0))();
  IntColumn get reviewCount => integer().withDefault(const Constant(0))();
  IntColumn get priceLevel => integer().withDefault(const Constant(1))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get updatedAt => text()();
  TextColumn get createdAt => text()();
  @override Set<Column> get primaryKey => {id};
}

class CategoriesTable extends Table {
  @override String get tableName => 'categories';
  IntColumn get id => integer()();
  TextColumn get nameAr => text()();
  TextColumn get nameEn => text()();
  TextColumn get icon => text().nullable()();
  TextColumn get updatedAt => text()();
  @override Set<Column> get primaryKey => {id};
}

class PlaceCategoriesTable extends Table {
  @override String get tableName => 'place_categories';
  IntColumn get placeId => integer().references(PlacesTable, #id)();
  IntColumn get categoryId => integer().references(CategoriesTable, #id)();
  @override Set<Column> get primaryKey => {placeId, categoryId};
}

class WorkingHoursTable extends Table {
  @override String get tableName => 'working_hours';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get placeId => integer().references(PlacesTable, #id)();
  IntColumn get dayOfWeek => integer()();
  TextColumn get openTime => text().withDefault(const Constant('00:00'))();
  TextColumn get closeTime => text().withDefault(const Constant('00:00'))();
  BoolColumn get isClosed => boolean().withDefault(const Constant(false))();
}

class PlaceImagesTable extends Table {
  @override String get tableName => 'place_images';
  IntColumn get id => integer()();
  IntColumn get placeId => integer().references(PlacesTable, #id)();
  TextColumn get url => text()();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  @override Set<Column> get primaryKey => {id};
}

class SocialLinksTable extends Table {
  @override String get tableName => 'social_links';
  IntColumn get id => integer()();
  IntColumn get placeId => integer().references(PlacesTable, #id)();
  TextColumn get platform => text()();
  TextColumn get url => text()();
  @override Set<Column> get primaryKey => {id};
}

class UserFavoritesTable extends Table {
  @override String get tableName => 'user_favorites';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  IntColumn get placeId => integer().references(PlacesTable, #id)();
  TextColumn get createdAt => text()();
}

class ChatSessionsTable extends Table {
  @override String get tableName => 'chat_sessions';
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().nullable()();
  TextColumn get startedAt => text()();
  TextColumn get language => text().withDefault(const Constant('en'))();
}

class ChatMessagesTable extends Table {
  @override String get tableName => 'chat_messages';
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId => integer().references(ChatSessionsTable, #id)();
  TextColumn get role => text()();
  TextColumn get content => text()();
  TextColumn get timestamp => text()();
}

class SyncMetadataTable extends Table {
  @override String get tableName => 'sync_metadata';
  TextColumn get key => text()();
  TextColumn get value => text()();
  @override Set<Column> get primaryKey => {key};
}

@DriftDatabase(
  tables: [PlacesTable, CategoriesTable, PlaceCategoriesTable, WorkingHoursTable,
    PlaceImagesTable, SocialLinksTable, UserFavoritesTable, ChatSessionsTable,
    ChatMessagesTable, SyncMetadataTable],
  daos: [PlacesDao, CategoriesDao, FavoritesDao, ChatDao, SyncDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.e);
  @override int get schemaVersion => 1;
  @override MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _fts5();
      await _indexes();
    },
  );

  Future<void> _fts5() async {
    await customStatement('''CREATE VIRTUAL TABLE IF NOT EXISTS places_fts USING fts5(
      place_id UNINDEXED, name_ar, name_en, description_ar, description_en,
      address_ar, address_en, tokenize="unicode61")''');
    await customStatement('''CREATE TRIGGER IF NOT EXISTS places_ai AFTER INSERT ON places BEGIN
      INSERT INTO places_fts(place_id,name_ar,name_en,description_ar,description_en,address_ar,address_en)
      VALUES(new.id,new.name_ar,new.name_en,new.description_ar,new.description_en,new.address_ar,new.address_en); END''');
    await customStatement('''CREATE TRIGGER IF NOT EXISTS places_ad AFTER DELETE ON places BEGIN
      DELETE FROM places_fts WHERE place_id=old.id; END''');
    await customStatement('''CREATE TRIGGER IF NOT EXISTS places_au AFTER UPDATE ON places BEGIN
      DELETE FROM places_fts WHERE place_id=old.id;
      INSERT INTO places_fts(place_id,name_ar,name_en,description_ar,description_en,address_ar,address_en)
      VALUES(new.id,new.name_ar,new.name_en,new.description_ar,new.description_en,new.address_ar,new.address_en); END''');
  }

  Future<void> _indexes() async {
    await customStatement('CREATE INDEX IF NOT EXISTS idx_places_rating ON places(rating)');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_places_active ON places(is_active)');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_pc_place ON place_categories(place_id)');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_wh_place ON working_hours(place_id)');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_img_place ON place_images(place_id)');
    await customStatement('CREATE INDEX IF NOT EXISTS idx_fav_user ON user_favorites(user_id)');
  }
}

// Platform-aware connection: uses NativeDatabase on mobile/desktop
// and WebDatabase on browser. See connection/shared.dart.
QueryExecutor _openConnection() => openDatabaseConnection();
