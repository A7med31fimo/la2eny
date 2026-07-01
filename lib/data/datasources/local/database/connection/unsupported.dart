import 'package:drift/drift.dart';

QueryExecutor openDatabaseConnection() {
  throw UnsupportedError(
    'Cannot open a database on this platform. '
    'Drift requires dart:ffi (native) or dart:html (web).',
  );
}
