import 'package:drift/drift.dart';
import '../app_database.dart';

part 'favorites_dao.g.dart';

@DriftAccessor(tables: [UserFavoritesTable, PlacesTable])
class FavoritesDao extends DatabaseAccessor<AppDatabase>
    with _$FavoritesDaoMixin {
  FavoritesDao(super.db);

  Future<List<int>> getFavoriteIds(String userId) async {
    final query = selectOnly(userFavoritesTable)
      ..where(userFavoritesTable.userId.equals(userId))
      ..addColumns([userFavoritesTable.placeId]);
    final rows = await query.get();
    return rows.map((r) => r.read(userFavoritesTable.placeId)!).toList();
  }

  Future<bool> isFavorite(String userId, int placeId) async {
    final query = select(userFavoritesTable)
      ..where((f) => f.userId.equals(userId))
      ..where((f) => f.placeId.equals(placeId));
    final result = await query.getSingleOrNull();
    return result != null;
  }

  Future<void> addFavorite(String userId, int placeId) =>
      into(userFavoritesTable).insertOnConflictUpdate(
        UserFavoritesTableCompanion.insert(
          userId: userId,
          placeId: placeId,
          createdAt: DateTime.now().toIso8601String(),
        ),
      );

  Future<void> removeFavorite(String userId, int placeId) =>
      (delete(userFavoritesTable)
            ..where((f) => f.userId.equals(userId))
            ..where((f) => f.placeId.equals(placeId)))
          .go();

  Future<List<PlacesTableData>> getFavoritePlaces(String userId) async {
    final query = select(placesTable).join([
      innerJoin(userFavoritesTable,
          userFavoritesTable.placeId.equalsExp(placesTable.id)),
    ])
      ..where(userFavoritesTable.userId.equals(userId))
      ..where(placesTable.isActive.equals(true));
    final rows = await query.get();
    return rows.map((r) => r.readTable(placesTable)).toList();
  }
}
