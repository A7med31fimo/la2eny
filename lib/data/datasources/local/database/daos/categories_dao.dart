import 'package:drift/drift.dart';
import '../app_database.dart';
part 'categories_dao.g.dart';

@DriftAccessor(tables: [CategoriesTable])
class CategoriesDao extends DatabaseAccessor<AppDatabase> with _$CategoriesDaoMixin {
  CategoriesDao(super.db);
  Future<List<CategoriesTableData>> getAllCategories() =>
      (select(categoriesTable)..orderBy([(c) => OrderingTerm.asc(c.nameEn)])).get();
  Future<void> upsertCategory(CategoriesTableCompanion c) => into(categoriesTable).insertOnConflictUpdate(c);
  Future<void> batchUpsertCategories(List<CategoriesTableCompanion> cats) async =>
      batch((b) => b.insertAllOnConflictUpdate(categoriesTable, cats));
}
