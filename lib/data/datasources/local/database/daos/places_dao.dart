import 'package:drift/drift.dart';
import '../app_database.dart';

part 'places_dao.g.dart';

@DriftAccessor(tables: [
  PlacesTable,
  CategoriesTable,
  PlaceCategoriesTable,
  WorkingHoursTable,
  PlaceImagesTable,
  SocialLinksTable,
])
class PlacesDao extends DatabaseAccessor<AppDatabase> with _$PlacesDaoMixin {
  PlacesDao(super.db);

  Future<List<PlacesTableData>> getAllActivePlaces() =>
      (select(placesTable)..where((p) => p.isActive.equals(true))).get();

  Future<PlacesTableData?> getPlaceById(int id) =>
      (select(placesTable)..where((p) => p.id.equals(id))).getSingleOrNull();

  Future<List<PlacesTableData>> getPlacesByCategory(int categoryId) async {
    final query = select(placesTable).join([
      innerJoin(placeCategoriesTable,
          placeCategoriesTable.placeId.equalsExp(placesTable.id)),
    ])
      ..where(placeCategoriesTable.categoryId.equals(categoryId))
      ..where(placesTable.isActive.equals(true));
    final rows = await query.get();
    return rows.map((r) => r.readTable(placesTable)).toList();
  }

  Future<List<PlacesTableData>> searchPlaces(String query) async {
    final sanitized = query.trim().replaceAll('"', '').replaceAll("'", '');
    if (sanitized.isEmpty) return [];
    final ftsQuery = '$sanitized*';
    final rows = await customSelect(
      '''
      SELECT p.* FROM places p
      INNER JOIN places_fts f ON p.id = f.place_id
      WHERE places_fts MATCH ? AND p.is_active = 1
      ORDER BY rank LIMIT 50
      ''',
      variables: [Variable.withString(ftsQuery)],
      readsFrom: {placesTable},
    ).get();
    return rows.map((row) => PlacesTableData(
          id: row.read<int>('id'),
          nameAr: row.read<String>('name_ar'),
          nameEn: row.read<String>('name_en'),
          descriptionAr: row.read<String>('description_ar'),
          descriptionEn: row.read<String>('description_en'),
          addressAr: row.read<String>('address_ar'),
          addressEn: row.read<String>('address_en'),
          latitude: row.read<double>('latitude'),
          longitude: row.read<double>('longitude'),
          phone: row.readNullable<String>('phone'),
          website: row.readNullable<String>('website'),
          rating: row.read<double>('rating'),
          reviewCount: row.read<int>('review_count'),
          priceLevel: row.read<int>('price_level'),
          isActive: row.read<bool>('is_active'),
          updatedAt: row.read<String>('updated_at'),
          createdAt: row.read<String>('created_at'),
        )).toList();
  }

  Future<List<CategoriesTableData>> getCategoriesForPlace(int placeId) async {
    final query = select(categoriesTable).join([
      innerJoin(placeCategoriesTable,
          placeCategoriesTable.categoryId.equalsExp(categoriesTable.id)),
    ])
      ..where(placeCategoriesTable.placeId.equals(placeId));
    final rows = await query.get();
    return rows.map((r) => r.readTable(categoriesTable)).toList();
  }

  Future<List<WorkingHoursTableData>> getWorkingHoursForPlace(int placeId) =>
      (select(workingHoursTable)
            ..where((h) => h.placeId.equals(placeId))
            ..orderBy([(h) => OrderingTerm.asc(h.dayOfWeek)]))
          .get();

  Future<List<PlaceImagesTableData>> getImagesForPlace(int placeId) =>
      (select(placeImagesTable)
            ..where((i) => i.placeId.equals(placeId))
            ..orderBy([
              (i) => OrderingTerm.desc(i.isPrimary),
              (i) => OrderingTerm.asc(i.sortOrder),
            ]))
          .get();

  Future<List<SocialLinksTableData>> getSocialLinksForPlace(int placeId) =>
      (select(socialLinksTable)..where((s) => s.placeId.equals(placeId))).get();

  Future<void> upsertPlace(PlacesTableCompanion place) =>
      into(placesTable).insertOnConflictUpdate(place);

  Future<void> upsertCategory(CategoriesTableCompanion category) =>
      into(categoriesTable).insertOnConflictUpdate(category);

  Future<void> upsertPlaceCategory(PlaceCategoriesTableCompanion pc) =>
      into(placeCategoriesTable).insertOnConflictUpdate(pc);

  Future<void> upsertWorkingHours(WorkingHoursTableCompanion hours) =>
      into(workingHoursTable).insertOnConflictUpdate(hours);

  Future<void> upsertImage(PlaceImagesTableCompanion image) =>
      into(placeImagesTable).insertOnConflictUpdate(image);

  Future<void> upsertSocialLink(SocialLinksTableCompanion link) =>
      into(socialLinksTable).insertOnConflictUpdate(link);

  Future<void> clearPlaceRelations(int placeId) async {
    await (delete(placeCategoriesTable)
          ..where((pc) => pc.placeId.equals(placeId)))
        .go();
    await (delete(workingHoursTable)..where((h) => h.placeId.equals(placeId)))
        .go();
    await (delete(placeImagesTable)..where((i) => i.placeId.equals(placeId)))
        .go();
    await (delete(socialLinksTable)..where((s) => s.placeId.equals(placeId)))
        .go();
  }

  Future<void> batchUpsertPlaces(List<PlacesTableCompanion> places) async {
    await batch((b) => b.insertAllOnConflictUpdate(placesTable, places));
  }
}
