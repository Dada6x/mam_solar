import 'package:drift/drift.dart';

class ProtocolsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get type => text()();
  TextColumn get customerName => text().nullable()();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
  TextColumn get status => text()();
  TextColumn get jsonData => text()();
  TextColumn get pdfPath => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
