import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor openConnection() {
  // Uses IndexedDB in the browser
  return WebDatabase('studymate');
}

