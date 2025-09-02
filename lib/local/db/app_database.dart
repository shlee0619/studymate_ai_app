import 'package:drift/drift.dart';
import 'package:studymate_ai_app/local/db/connection/connection.dart';

part 'app_database.g.dart';

class Studies extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  RealColumn get progress => real().withDefault(const Constant(0.0))();
  IntColumn get lastActivityMillis => integer()();
  TextColumn get tagsJson => text().withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {id};
}

class ChatMessagesTable extends Table {
  TextColumn get id => text()();
  TextColumn get conversationId => text().withDefault(const Constant('default'))();
  TextColumn get role => text()(); // user|assistant|system
  TextColumn get text_ => text()();
  IntColumn get createdAtMillis => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Studies, ChatMessagesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  // Studies CRUD
  Future<List<Study>> getAllStudies() => select(studies).get();

  Future<void> insertStudy(Insertable<Study> data) => into(studies).insertOnConflictUpdate(data);

  Future<void> deleteStudy(String id) => (delete(studies)..where((tbl) => tbl.id.equals(id))).go();

  // Chat messages
  Stream<List<ChatMessagesTableData>> watchMessages(String conversationId) {
    return (select(chatMessagesTable)
          ..where((tbl) => tbl.conversationId.equals(conversationId))
          ..orderBy([(t) => OrderingTerm.asc(t.createdAtMillis)]))
        .watch();
  }

  Future<void> insertMessage(Insertable<ChatMessagesTableData> data) =>
      into(chatMessagesTable).insertOnConflictUpdate(data);

  Future<void> clearConversation(String conversationId) =>
      (delete(chatMessagesTable)..where((t) => t.conversationId.equals(conversationId))).go();
}

// See local/db/connection for platform-specific connection implementations.
