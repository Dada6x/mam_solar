import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:mam_solar/data/database/app_database.dart';
import 'package:mam_solar/data/models/protocol_model.dart';

class ProtocolRepository {
  final AppDatabase _db;

  ProtocolRepository(this._db);

  Future<int> insertProtocol(ProtocolModel protocol) async {
    return await _db
        .into(_db.protocolsTable)
        .insert(
          ProtocolsTableCompanion(
            id: Value.absent(),
            type: Value(protocol.type),
            customerName: Value(protocol.customerName),
            createdAt: Value(protocol.createdAt),
            updatedAt: Value(protocol.updatedAt),
            status: Value(protocol.status),
            jsonData: Value(protocol.jsonData),
            pdfPath: Value(protocol.pdfPath),
          ),
        );
  }

  Future<void> updateProtocol(ProtocolModel protocol) async {
    await (_db.protocolsTable.update()
          ..where((tbl) => tbl.id.equals(protocol.id)))
        .write(
          ProtocolsTableCompanion(
            type: Value(protocol.type),
            customerName: Value(protocol.customerName),
            createdAt: Value(protocol.createdAt),
            updatedAt: Value(protocol.updatedAt),
            status: Value(protocol.status),
            jsonData: Value(protocol.jsonData),
            pdfPath: Value(protocol.pdfPath),
          ),
        );
  }

  Future<void> updateJsonData(
    int id,
    Map<String, dynamic> data, {
    String? customerName,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.protocolsTable.update()..where((tbl) => tbl.id.equals(id)))
        .write(
          ProtocolsTableCompanion(
            jsonData: Value(json.encode(data)),
            updatedAt: Value(now),
            // Keep the queryable customerName column in sync with the form so
            // the finished-protocols list and customer search work.
            customerName: customerName != null
                ? Value(customerName)
                : const Value.absent(),
          ),
        );
  }

  /// Marks a protocol as finished (locked / read-only).
  Future<void> markCompleted(int id) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.protocolsTable.update()..where((tbl) => tbl.id.equals(id)))
        .write(
          ProtocolsTableCompanion(
            status: const Value('completed'),
            updatedAt: Value(now),
          ),
        );
  }

  /// Creates a new editable DRAFT copy of an existing protocol (e.g. to fix a
  /// finished one without changing the locked original). Returns the new id.
  Future<int> duplicateAsDraft(int id) async {
    final src =
        await (_db.protocolsTable.select()..where((tbl) => tbl.id.equals(id)))
            .getSingleOrNull();
    if (src == null) return 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    return await _db.into(_db.protocolsTable).insert(
          ProtocolsTableCompanion(
            id: const Value.absent(),
            type: Value(src.type),
            customerName: Value(src.customerName),
            createdAt: Value(now),
            updatedAt: Value(now),
            status: const Value('draft'),
            jsonData: Value(src.jsonData),
            pdfPath: const Value(null),
          ),
        );
  }

  /// Finished protocols whose customer name contains [query] (case-insensitive).
  Future<List<ProtocolModel>> searchCompletedByCustomer(String query) async {
    final like = '%${query.trim()}%';
    final rows = await (_db.protocolsTable.select()
          ..where((tbl) => tbl.status.equals('completed'))
          ..where((tbl) => tbl.customerName.lower().like(like.toLowerCase()))
          ..orderBy([
            (tbl) => OrderingTerm(
                  expression: tbl.updatedAt,
                  mode: OrderingMode.desc,
                ),
          ]))
        .get();
    return rows
        .map(
          (row) => ProtocolModel(
            id: row.id,
            type: row.type,
            customerName: row.customerName,
            createdAt: row.createdAt,
            updatedAt: row.updatedAt,
            status: row.status,
            jsonData: row.jsonData,
            pdfPath: row.pdfPath,
          ),
        )
        .toList();
  }

  Future<ProtocolModel?> getProtocol(int id) async {
    final row =
        await (_db.protocolsTable.select()..where((tbl) => tbl.id.equals(id)))
            .getSingleOrNull();
    if (row == null) return null;
    return ProtocolModel(
      id: row.id,
      type: row.type,
      customerName: row.customerName,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      status: row.status,
      jsonData: row.jsonData,
      pdfPath: row.pdfPath,
    );
  }

  Future<List<ProtocolModel>> getAllProtocols() async {
    final rows = await _db.protocolsTable.select().get();
    return rows
        .map(
          (row) => ProtocolModel(
            id: row.id,
            type: row.type,
            customerName: row.customerName,
            createdAt: row.createdAt,
            updatedAt: row.updatedAt,
            status: row.status,
            jsonData: row.jsonData,
            pdfPath: row.pdfPath,
          ),
        )
        .toList();
  }

  Future<List<ProtocolModel>> getDrafts() async {
    final rows =
        await (_db.protocolsTable.select()
              ..where((tbl) => tbl.status.equals('draft'))
              ..orderBy([
                (tbl) => OrderingTerm(
                  expression: tbl.updatedAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows
        .map(
          (row) => ProtocolModel(
            id: row.id,
            type: row.type,
            customerName: row.customerName,
            createdAt: row.createdAt,
            updatedAt: row.updatedAt,
            status: row.status,
            jsonData: row.jsonData,
            pdfPath: row.pdfPath,
          ),
        )
        .toList();
  }

  Future<List<ProtocolModel>> getCompleted() async {
    final rows =
        await (_db.protocolsTable.select()
              ..where((tbl) => tbl.status.equals('completed'))
              ..orderBy([
                (tbl) => OrderingTerm(
                  expression: tbl.updatedAt,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();
    return rows
        .map(
          (row) => ProtocolModel(
            id: row.id,
            type: row.type,
            customerName: row.customerName,
            createdAt: row.createdAt,
            updatedAt: row.updatedAt,
            status: row.status,
            jsonData: row.jsonData,
            pdfPath: row.pdfPath,
          ),
        )
        .toList();
  }

  Future<void> deleteProtocol(int id) async {
    await (_db.protocolsTable.deleteWhere((tbl) => tbl.id.equals(id)));
  }

  Future<Map<String, dynamic>> getJsonData(int id) async {
    final row =
        await (_db.protocolsTable.select()..where((tbl) => tbl.id.equals(id)))
            .getSingleOrNull();
    if (row == null) return {};
    try {
      return json.decode(row.jsonData) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  Future<void> clearAll() async {
    await _db.protocolsTable.deleteAll();
  }

  Future<int> getDraftCount() async {
    final rows =
        await (_db.protocolsTable.select()
              ..where((tbl) => tbl.status.equals('draft')))
            .get();
    return rows.length;
  }
}
