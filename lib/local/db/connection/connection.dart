import 'package:drift/drift.dart';

// Conditional import dispatches to web or native implementation
import 'connection_web.dart' if (dart.library.io) 'connection_native.dart' as impl;

QueryExecutor openConnection() => impl.openConnection();
