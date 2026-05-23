import 'package:drift/drift.dart';
import 'package:mam_solar/data/database/tables/protocols_table.dart';

class SignaturesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get protocolId => integer().references(ProtocolsTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get type => text()();
  TextColumn get imagePath => text()();

  @override
  Set<Column> get primaryKey => {id};
}
