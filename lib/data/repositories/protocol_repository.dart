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
    await (_db.protocolsTable.update(
    )).write(
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

  Future<void> updateJsonData(int id, Map<String, dynamic> data) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    await (_db.protocolsTable.update()).write(
      ProtocolsTableCompanion(
        jsonData: Value(json.encode(data)),
        updatedAt: Value(now),
      ),
    );
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
