import 'package:drift/drift.dart';
import '../app_database.dart';

part 'categories_dao.g.dart';

@DriftAccessor(tables: [CategoriesTable])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(super.db);

  Future<List<CategoriesTableData>> getAllCategories() =>
      (select(categoriesTable)
            ..orderBy([(c) => OrderingTerm.asc(c.nameEn)]))
          .get();

  Future<CategoriesTableData?> getCategoryById(int id) =>
      (select(categoriesTable)..where((c) => c.id.equals(id)))
          .getSingleOrNull();

  Future<void> upsertCategory(CategoriesTableCompanion category) =>
      into(categoriesTable).insertOnConflictUpdate(category);

  Future<void> batchUpsertCategories(
      List<CategoriesTableCompanion> categories) async {
    await batch((b) =>
        b.insertAllOnConflictUpdate(categoriesTable, categories));
  }
}
