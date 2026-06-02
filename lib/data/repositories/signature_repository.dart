import 'dart:io';
import 'package:drift/drift.dart';
import 'package:mam_solar/data/database/app_database.dart';
import 'package:mam_solar/data/models/signature_model.dart';

class SignatureRepository {
  final AppDatabase _db;

  SignatureRepository(this._db);

  Future<int> insertSignature(SignatureModel sig) async {
    return await _db
        .into(_db.signaturesTable)
        .insert(
          SignaturesTableCompanion(
            protocolId: Value(sig.protocolId),
            type: Value(sig.type),
            imagePath: Value(sig.imagePath),
          ),
        );
  }

  Future<SignatureModel?> getSignature(int protocolId, String type) async {
    final row =
        await (_db.signaturesTable.select()..where(
              (tbl) =>
                  tbl.protocolId.equals(protocolId) & tbl.type.equals(type),
            ))
            .getSingleOrNull();
    if (row == null) return null;
    return SignatureModel(
      id: row.id,
      protocolId: row.protocolId,
      type: row.type,
      imagePath: row.imagePath,
    );
  }

  Future<List<SignatureModel>> getSignaturesForProtocol(int protocolId) async {
    final rows =
        await (_db.signaturesTable.select()
              ..where((tbl) => tbl.protocolId.equals(protocolId)))
            .get();
    return rows
        .map(
          (row) => SignatureModel(
            id: row.id,
            protocolId: row.protocolId,
            type: row.type,
            imagePath: row.imagePath,
          ),
        )
        .toList();
  }

  Future<void> deleteSignature(int id) async {
    await (_db.signaturesTable.deleteWhere((tbl) => tbl.id.equals(id)));
  }

  Future<void> deleteSignatureForProtocol(int protocolId, String type) async {
    await (_db.signaturesTable.deleteWhere(
      (tbl) => tbl.protocolId.equals(protocolId) & tbl.type.equals(type),
    ));
  }

  Future<void> clearAll() async {
    await _db.signaturesTable.deleteAll();
  }

  Future<void> saveSignatureImage(
    int protocolId,
    String type,
    String imagePath,
  ) async {
    final existing = await getSignature(protocolId, type);
    if (existing != null) {
      final oldFile = File(existing.imagePath);
      if (oldFile.existsSync()) {
        oldFile.deleteSync();
      }
      await (_db.signaturesTable.update()
        ..where((tbl) => tbl.id.equals(existing.id))
      ).write(
        SignaturesTableCompanion(imagePath: Value(imagePath)),
      );
    } else {
      await _db
          .into(_db.signaturesTable)
          .insert(
            SignaturesTableCompanion(
              protocolId: Value(protocolId),
              type: Value(type),
              imagePath: Value(imagePath),
            ),
          );
    }
  }
}
