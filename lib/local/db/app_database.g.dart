// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $StudiesTable extends Studies with TableInfo<$StudiesTable, Study> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _lastActivityMillisMeta =
      const VerificationMeta('lastActivityMillis');
  @override
  late final GeneratedColumn<int> lastActivityMillis = GeneratedColumn<int>(
    'last_activity_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagsJsonMeta = const VerificationMeta(
    'tagsJson',
  );
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
    'tags_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    progress,
    lastActivityMillis,
    tagsJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'studies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Study> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('last_activity_millis')) {
      context.handle(
        _lastActivityMillisMeta,
        lastActivityMillis.isAcceptableOrUnknown(
          data['last_activity_millis']!,
          _lastActivityMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastActivityMillisMeta);
    }
    if (data.containsKey('tags_json')) {
      context.handle(
        _tagsJsonMeta,
        tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Study map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Study(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      lastActivityMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}last_activity_millis'],
      )!,
      tagsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags_json'],
      )!,
    );
  }

  @override
  $StudiesTable createAlias(String alias) {
    return $StudiesTable(attachedDatabase, alias);
  }
}

class Study extends DataClass implements Insertable<Study> {
  final String id;
  final String title;
  final double progress;
  final int lastActivityMillis;
  final String tagsJson;
  const Study({
    required this.id,
    required this.title,
    required this.progress,
    required this.lastActivityMillis,
    required this.tagsJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['progress'] = Variable<double>(progress);
    map['last_activity_millis'] = Variable<int>(lastActivityMillis);
    map['tags_json'] = Variable<String>(tagsJson);
    return map;
  }

  StudiesCompanion toCompanion(bool nullToAbsent) {
    return StudiesCompanion(
      id: Value(id),
      title: Value(title),
      progress: Value(progress),
      lastActivityMillis: Value(lastActivityMillis),
      tagsJson: Value(tagsJson),
    );
  }

  factory Study.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Study(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      progress: serializer.fromJson<double>(json['progress']),
      lastActivityMillis: serializer.fromJson<int>(json['lastActivityMillis']),
      tagsJson: serializer.fromJson<String>(json['tagsJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'progress': serializer.toJson<double>(progress),
      'lastActivityMillis': serializer.toJson<int>(lastActivityMillis),
      'tagsJson': serializer.toJson<String>(tagsJson),
    };
  }

  Study copyWith({
    String? id,
    String? title,
    double? progress,
    int? lastActivityMillis,
    String? tagsJson,
  }) => Study(
    id: id ?? this.id,
    title: title ?? this.title,
    progress: progress ?? this.progress,
    lastActivityMillis: lastActivityMillis ?? this.lastActivityMillis,
    tagsJson: tagsJson ?? this.tagsJson,
  );
  Study copyWithCompanion(StudiesCompanion data) {
    return Study(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      progress: data.progress.present ? data.progress.value : this.progress,
      lastActivityMillis: data.lastActivityMillis.present
          ? data.lastActivityMillis.value
          : this.lastActivityMillis,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Study(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('progress: $progress, ')
          ..write('lastActivityMillis: $lastActivityMillis, ')
          ..write('tagsJson: $tagsJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, progress, lastActivityMillis, tagsJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Study &&
          other.id == this.id &&
          other.title == this.title &&
          other.progress == this.progress &&
          other.lastActivityMillis == this.lastActivityMillis &&
          other.tagsJson == this.tagsJson);
}

class StudiesCompanion extends UpdateCompanion<Study> {
  final Value<String> id;
  final Value<String> title;
  final Value<double> progress;
  final Value<int> lastActivityMillis;
  final Value<String> tagsJson;
  final Value<int> rowid;
  const StudiesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.progress = const Value.absent(),
    this.lastActivityMillis = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudiesCompanion.insert({
    required String id,
    required String title,
    this.progress = const Value.absent(),
    required int lastActivityMillis,
    this.tagsJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       lastActivityMillis = Value(lastActivityMillis);
  static Insertable<Study> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<double>? progress,
    Expression<int>? lastActivityMillis,
    Expression<String>? tagsJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (progress != null) 'progress': progress,
      if (lastActivityMillis != null)
        'last_activity_millis': lastActivityMillis,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudiesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<double>? progress,
    Value<int>? lastActivityMillis,
    Value<String>? tagsJson,
    Value<int>? rowid,
  }) {
    return StudiesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      progress: progress ?? this.progress,
      lastActivityMillis: lastActivityMillis ?? this.lastActivityMillis,
      tagsJson: tagsJson ?? this.tagsJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (lastActivityMillis.present) {
      map['last_activity_millis'] = Variable<int>(lastActivityMillis.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudiesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('progress: $progress, ')
          ..write('lastActivityMillis: $lastActivityMillis, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTableTable extends ChatMessagesTable
    with TableInfo<$ChatMessagesTableTable, ChatMessagesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<String> conversationId = GeneratedColumn<String>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('default'),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _text_Meta = const VerificationMeta('text_');
  @override
  late final GeneratedColumn<String> text_ = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMillisMeta = const VerificationMeta(
    'createdAtMillis',
  );
  @override
  late final GeneratedColumn<int> createdAtMillis = GeneratedColumn<int>(
    'created_at_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    role,
    text_,
    createdAtMillis,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMessagesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _text_Meta,
        text_.isAcceptableOrUnknown(data['text']!, _text_Meta),
      );
    } else if (isInserting) {
      context.missing(_text_Meta);
    }
    if (data.containsKey('created_at_millis')) {
      context.handle(
        _createdAtMillisMeta,
        createdAtMillis.isAcceptableOrUnknown(
          data['created_at_millis']!,
          _createdAtMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMillisMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessagesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessagesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conversation_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      text_: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      createdAtMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_millis'],
      )!,
    );
  }

  @override
  $ChatMessagesTableTable createAlias(String alias) {
    return $ChatMessagesTableTable(attachedDatabase, alias);
  }
}

class ChatMessagesTableData extends DataClass
    implements Insertable<ChatMessagesTableData> {
  final String id;
  final String conversationId;
  final String role;
  final String text_;
  final int createdAtMillis;
  const ChatMessagesTableData({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.text_,
    required this.createdAtMillis,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['conversation_id'] = Variable<String>(conversationId);
    map['role'] = Variable<String>(role);
    map['text'] = Variable<String>(text_);
    map['created_at_millis'] = Variable<int>(createdAtMillis);
    return map;
  }

  ChatMessagesTableCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesTableCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      role: Value(role),
      text_: Value(text_),
      createdAtMillis: Value(createdAtMillis),
    );
  }

  factory ChatMessagesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessagesTableData(
      id: serializer.fromJson<String>(json['id']),
      conversationId: serializer.fromJson<String>(json['conversationId']),
      role: serializer.fromJson<String>(json['role']),
      text_: serializer.fromJson<String>(json['text_']),
      createdAtMillis: serializer.fromJson<int>(json['createdAtMillis']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'conversationId': serializer.toJson<String>(conversationId),
      'role': serializer.toJson<String>(role),
      'text_': serializer.toJson<String>(text_),
      'createdAtMillis': serializer.toJson<int>(createdAtMillis),
    };
  }

  ChatMessagesTableData copyWith({
    String? id,
    String? conversationId,
    String? role,
    String? text_,
    int? createdAtMillis,
  }) => ChatMessagesTableData(
    id: id ?? this.id,
    conversationId: conversationId ?? this.conversationId,
    role: role ?? this.role,
    text_: text_ ?? this.text_,
    createdAtMillis: createdAtMillis ?? this.createdAtMillis,
  );
  ChatMessagesTableData copyWithCompanion(ChatMessagesTableCompanion data) {
    return ChatMessagesTableData(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      role: data.role.present ? data.role.value : this.role,
      text_: data.text_.present ? data.text_.value : this.text_,
      createdAtMillis: data.createdAtMillis.present
          ? data.createdAtMillis.value
          : this.createdAtMillis,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesTableData(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('text_: $text_, ')
          ..write('createdAtMillis: $createdAtMillis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, conversationId, role, text_, createdAtMillis);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessagesTableData &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.role == this.role &&
          other.text_ == this.text_ &&
          other.createdAtMillis == this.createdAtMillis);
}

class ChatMessagesTableCompanion
    extends UpdateCompanion<ChatMessagesTableData> {
  final Value<String> id;
  final Value<String> conversationId;
  final Value<String> role;
  final Value<String> text_;
  final Value<int> createdAtMillis;
  final Value<int> rowid;
  const ChatMessagesTableCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.role = const Value.absent(),
    this.text_ = const Value.absent(),
    this.createdAtMillis = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ChatMessagesTableCompanion.insert({
    required String id,
    this.conversationId = const Value.absent(),
    required String role,
    required String text_,
    required int createdAtMillis,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       role = Value(role),
       text_ = Value(text_),
       createdAtMillis = Value(createdAtMillis);
  static Insertable<ChatMessagesTableData> custom({
    Expression<String>? id,
    Expression<String>? conversationId,
    Expression<String>? role,
    Expression<String>? text_,
    Expression<int>? createdAtMillis,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (role != null) 'role': role,
      if (text_ != null) 'text': text_,
      if (createdAtMillis != null) 'created_at_millis': createdAtMillis,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ChatMessagesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? conversationId,
    Value<String>? role,
    Value<String>? text_,
    Value<int>? createdAtMillis,
    Value<int>? rowid,
  }) {
    return ChatMessagesTableCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      text_: text_ ?? this.text_,
      createdAtMillis: createdAtMillis ?? this.createdAtMillis,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<String>(conversationId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (text_.present) {
      map['text'] = Variable<String>(text_.value);
    }
    if (createdAtMillis.present) {
      map['created_at_millis'] = Variable<int>(createdAtMillis.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesTableCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('text_: $text_, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StudiesTable studies = $StudiesTable(this);
  late final $ChatMessagesTableTable chatMessagesTable =
      $ChatMessagesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    studies,
    chatMessagesTable,
  ];
}

typedef $$StudiesTableCreateCompanionBuilder =
    StudiesCompanion Function({
      required String id,
      required String title,
      Value<double> progress,
      required int lastActivityMillis,
      Value<String> tagsJson,
      Value<int> rowid,
    });
typedef $$StudiesTableUpdateCompanionBuilder =
    StudiesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<double> progress,
      Value<int> lastActivityMillis,
      Value<String> tagsJson,
      Value<int> rowid,
    });

class $$StudiesTableFilterComposer
    extends Composer<_$AppDatabase, $StudiesTable> {
  $$StudiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lastActivityMillis => $composableBuilder(
    column: $table.lastActivityMillis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StudiesTableOrderingComposer
    extends Composer<_$AppDatabase, $StudiesTable> {
  $$StudiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lastActivityMillis => $composableBuilder(
    column: $table.lastActivityMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagsJson => $composableBuilder(
    column: $table.tagsJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StudiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudiesTable> {
  $$StudiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get lastActivityMillis => $composableBuilder(
    column: $table.lastActivityMillis,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);
}

class $$StudiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StudiesTable,
          Study,
          $$StudiesTableFilterComposer,
          $$StudiesTableOrderingComposer,
          $$StudiesTableAnnotationComposer,
          $$StudiesTableCreateCompanionBuilder,
          $$StudiesTableUpdateCompanionBuilder,
          (Study, BaseReferences<_$AppDatabase, $StudiesTable, Study>),
          Study,
          PrefetchHooks Function()
        > {
  $$StudiesTableTableManager(_$AppDatabase db, $StudiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<int> lastActivityMillis = const Value.absent(),
                Value<String> tagsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudiesCompanion(
                id: id,
                title: title,
                progress: progress,
                lastActivityMillis: lastActivityMillis,
                tagsJson: tagsJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<double> progress = const Value.absent(),
                required int lastActivityMillis,
                Value<String> tagsJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StudiesCompanion.insert(
                id: id,
                title: title,
                progress: progress,
                lastActivityMillis: lastActivityMillis,
                tagsJson: tagsJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StudiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StudiesTable,
      Study,
      $$StudiesTableFilterComposer,
      $$StudiesTableOrderingComposer,
      $$StudiesTableAnnotationComposer,
      $$StudiesTableCreateCompanionBuilder,
      $$StudiesTableUpdateCompanionBuilder,
      (Study, BaseReferences<_$AppDatabase, $StudiesTable, Study>),
      Study,
      PrefetchHooks Function()
    >;
typedef $$ChatMessagesTableTableCreateCompanionBuilder =
    ChatMessagesTableCompanion Function({
      required String id,
      Value<String> conversationId,
      required String role,
      required String text_,
      required int createdAtMillis,
      Value<int> rowid,
    });
typedef $$ChatMessagesTableTableUpdateCompanionBuilder =
    ChatMessagesTableCompanion Function({
      Value<String> id,
      Value<String> conversationId,
      Value<String> role,
      Value<String> text_,
      Value<int> createdAtMillis,
      Value<int> rowid,
    });

class $$ChatMessagesTableTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get text_ => $composableBuilder(
    column: $table.text_,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ChatMessagesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get text_ => $composableBuilder(
    column: $table.text_,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ChatMessagesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessagesTableTable> {
  $$ChatMessagesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get conversationId => $composableBuilder(
    column: $table.conversationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get text_ =>
      $composableBuilder(column: $table.text_, builder: (column) => column);

  GeneratedColumn<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => column,
  );
}

class $$ChatMessagesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatMessagesTableTable,
          ChatMessagesTableData,
          $$ChatMessagesTableTableFilterComposer,
          $$ChatMessagesTableTableOrderingComposer,
          $$ChatMessagesTableTableAnnotationComposer,
          $$ChatMessagesTableTableCreateCompanionBuilder,
          $$ChatMessagesTableTableUpdateCompanionBuilder,
          (
            ChatMessagesTableData,
            BaseReferences<
              _$AppDatabase,
              $ChatMessagesTableTable,
              ChatMessagesTableData
            >,
          ),
          ChatMessagesTableData,
          PrefetchHooks Function()
        > {
  $$ChatMessagesTableTableTableManager(
    _$AppDatabase db,
    $ChatMessagesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> conversationId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> text_ = const Value.absent(),
                Value<int> createdAtMillis = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ChatMessagesTableCompanion(
                id: id,
                conversationId: conversationId,
                role: role,
                text_: text_,
                createdAtMillis: createdAtMillis,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String> conversationId = const Value.absent(),
                required String role,
                required String text_,
                required int createdAtMillis,
                Value<int> rowid = const Value.absent(),
              }) => ChatMessagesTableCompanion.insert(
                id: id,
                conversationId: conversationId,
                role: role,
                text_: text_,
                createdAtMillis: createdAtMillis,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ChatMessagesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatMessagesTableTable,
      ChatMessagesTableData,
      $$ChatMessagesTableTableFilterComposer,
      $$ChatMessagesTableTableOrderingComposer,
      $$ChatMessagesTableTableAnnotationComposer,
      $$ChatMessagesTableTableCreateCompanionBuilder,
      $$ChatMessagesTableTableUpdateCompanionBuilder,
      (
        ChatMessagesTableData,
        BaseReferences<
          _$AppDatabase,
          $ChatMessagesTableTable,
          ChatMessagesTableData
        >,
      ),
      ChatMessagesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StudiesTableTableManager get studies =>
      $$StudiesTableTableManager(_db, _db.studies);
  $$ChatMessagesTableTableTableManager get chatMessagesTable =>
      $$ChatMessagesTableTableTableManager(_db, _db.chatMessagesTable);
}
