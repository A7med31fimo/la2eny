import 'package:drift/drift.dart';
import '../app_database.dart';
part 'chat_dao.g.dart';

@DriftAccessor(tables: [ChatSessionsTable, ChatMessagesTable])
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  Future<int> createSession({String? userId, String language = 'en'}) =>
      into(chatSessionsTable).insert(ChatSessionsTableCompanion.insert(
        userId: Value(userId), startedAt: DateTime.now().toIso8601String(), language: Value(language)));

  Future<void> insertMessage({required int sessionId, required String role, required String content}) =>
      into(chatMessagesTable).insert(ChatMessagesTableCompanion.insert(
        sessionId: sessionId, role: role, content: content, timestamp: DateTime.now().toIso8601String()));

  Future<List<ChatMessagesTableData>> getMessagesForSession(int sessionId) =>
      (select(chatMessagesTable)..where((m) => m.sessionId.equals(sessionId))
        ..orderBy([(m) => OrderingTerm.asc(m.timestamp)])).get();

  Future<void> deleteSession(int sessionId) async {
    await (delete(chatMessagesTable)..where((m) => m.sessionId.equals(sessionId))).go();
    await (delete(chatSessionsTable)..where((s) => s.id.equals(sessionId))).go();
  }
}
