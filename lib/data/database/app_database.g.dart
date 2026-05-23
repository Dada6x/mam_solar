// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProtocolsTableTable extends ProtocolsTable
    with TableInfo<$ProtocolsTableTable, ProtocolsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProtocolsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonDataMeta = const VerificationMeta(
    'jsonData',
  );
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
    'json_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pdfPathMeta = const VerificationMeta(
    'pdfPath',
  );
  @override
  late final GeneratedColumn<String> pdfPath = GeneratedColumn<String>(
    'pdf_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    customerName,
    createdAt,
    updatedAt,
    status,
    jsonData,
    pdfPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'protocols_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProtocolsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('json_data')) {
      context.handle(
        _jsonDataMeta,
        jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonDataMeta);
    }
    if (data.containsKey('pdf_path')) {
      context.handle(
        _pdfPathMeta,
        pdfPath.isAcceptableOrUnknown(data['pdf_path']!, _pdfPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProtocolsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProtocolsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      jsonData: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json_data'],
      )!,
      pdfPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pdf_path'],
      ),
    );
  }

  @override
  $ProtocolsTableTable createAlias(String alias) {
    return $ProtocolsTableTable(attachedDatabase, alias);
  }
}

class ProtocolsTableData extends DataClass
    implements Insertable<ProtocolsTableData> {
  final int id;
  final String type;
  final String? customerName;
  final int createdAt;
  final int updatedAt;
  final String status;
  final String jsonData;
  final String? pdfPath;
  const ProtocolsTableData({
    required this.id,
    required this.type,
    this.customerName,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.jsonData,
    this.pdfPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || customerName != null) {
      map['customer_name'] = Variable<String>(customerName);
    }
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['status'] = Variable<String>(status);
    map['json_data'] = Variable<String>(jsonData);
    if (!nullToAbsent || pdfPath != null) {
      map['pdf_path'] = Variable<String>(pdfPath);
    }
    return map;
  }

  ProtocolsTableCompanion toCompanion(bool nullToAbsent) {
    return ProtocolsTableCompanion(
      id: Value(id),
      type: Value(type),
      customerName: customerName == null && nullToAbsent
          ? const Value.absent()
          : Value(customerName),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      status: Value(status),
      jsonData: Value(jsonData),
      pdfPath: pdfPath == null && nullToAbsent
          ? const Value.absent()
          : Value(pdfPath),
    );
  }

  factory ProtocolsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProtocolsTableData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      customerName: serializer.fromJson<String?>(json['customerName']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      status: serializer.fromJson<String>(json['status']),
      jsonData: serializer.fromJson<String>(json['jsonData']),
      pdfPath: serializer.fromJson<String?>(json['pdfPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'customerName': serializer.toJson<String?>(customerName),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'status': serializer.toJson<String>(status),
      'jsonData': serializer.toJson<String>(jsonData),
      'pdfPath': serializer.toJson<String?>(pdfPath),
    };
  }

  ProtocolsTableData copyWith({
    int? id,
    String? type,
    Value<String?> customerName = const Value.absent(),
    int? createdAt,
    int? updatedAt,
    String? status,
    String? jsonData,
    Value<String?> pdfPath = const Value.absent(),
  }) => ProtocolsTableData(
    id: id ?? this.id,
    type: type ?? this.type,
    customerName: customerName.present ? customerName.value : this.customerName,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    status: status ?? this.status,
    jsonData: jsonData ?? this.jsonData,
    pdfPath: pdfPath.present ? pdfPath.value : this.pdfPath,
  );
  ProtocolsTableData copyWithCompanion(ProtocolsTableCompanion data) {
    return ProtocolsTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      status: data.status.present ? data.status.value : this.status,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
      pdfPath: data.pdfPath.present ? data.pdfPath.value : this.pdfPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProtocolsTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('customerName: $customerName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('jsonData: $jsonData, ')
          ..write('pdfPath: $pdfPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    customerName,
    createdAt,
    updatedAt,
    status,
    jsonData,
    pdfPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProtocolsTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.customerName == this.customerName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.status == this.status &&
          other.jsonData == this.jsonData &&
          other.pdfPath == this.pdfPath);
}

class ProtocolsTableCompanion extends UpdateCompanion<ProtocolsTableData> {
  final Value<int> id;
  final Value<String> type;
  final Value<String?> customerName;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String> status;
  final Value<String> jsonData;
  final Value<String?> pdfPath;
  const ProtocolsTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.customerName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.pdfPath = const Value.absent(),
  });
  ProtocolsTableCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    this.customerName = const Value.absent(),
    required int createdAt,
    required int updatedAt,
    required String status,
    required String jsonData,
    this.pdfPath = const Value.absent(),
  }) : type = Value(type),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       status = Value(status),
       jsonData = Value(jsonData);
  static Insertable<ProtocolsTableData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? customerName,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? status,
    Expression<String>? jsonData,
    Expression<String>? pdfPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (customerName != null) 'customer_name': customerName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (status != null) 'status': status,
      if (jsonData != null) 'json_data': jsonData,
      if (pdfPath != null) 'pdf_path': pdfPath,
    });
  }

  ProtocolsTableCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String?>? customerName,
    Value<int>? createdAt,
    Value<int>? updatedAt,
    Value<String>? status,
    Value<String>? jsonData,
    Value<String?>? pdfPath,
  }) {
    return ProtocolsTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      customerName: customerName ?? this.customerName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      jsonData: jsonData ?? this.jsonData,
      pdfPath: pdfPath ?? this.pdfPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (pdfPath.present) {
      map['pdf_path'] = Variable<String>(pdfPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProtocolsTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('customerName: $customerName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('status: $status, ')
          ..write('jsonData: $jsonData, ')
          ..write('pdfPath: $pdfPath')
          ..write(')'))
        .toString();
  }
}

class $SignaturesTableTable extends SignaturesTable
    with TableInfo<$SignaturesTableTable, SignaturesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SignaturesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _protocolIdMeta = const VerificationMeta(
    'protocolId',
  );
  @override
  late final GeneratedColumn<int> protocolId = GeneratedColumn<int>(
    'protocol_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES protocols_table (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, protocolId, type, imagePath];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'signatures_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SignaturesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('protocol_id')) {
      context.handle(
        _protocolIdMeta,
        protocolId.isAcceptableOrUnknown(data['protocol_id']!, _protocolIdMeta),
      );
    } else if (isInserting) {
      context.missing(_protocolIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SignaturesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SignaturesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      protocolId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}protocol_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
    );
  }

  @override
  $SignaturesTableTable createAlias(String alias) {
    return $SignaturesTableTable(attachedDatabase, alias);
  }
}

class SignaturesTableData extends DataClass
    implements Insertable<SignaturesTableData> {
  final int id;
  final int protocolId;
  final String type;
  final String imagePath;
  const SignaturesTableData({
    required this.id,
    required this.protocolId,
    required this.type,
    required this.imagePath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['protocol_id'] = Variable<int>(protocolId);
    map['type'] = Variable<String>(type);
    map['image_path'] = Variable<String>(imagePath);
    return map;
  }

  SignaturesTableCompanion toCompanion(bool nullToAbsent) {
    return SignaturesTableCompanion(
      id: Value(id),
      protocolId: Value(protocolId),
      type: Value(type),
      imagePath: Value(imagePath),
    );
  }

  factory SignaturesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SignaturesTableData(
      id: serializer.fromJson<int>(json['id']),
      protocolId: serializer.fromJson<int>(json['protocolId']),
      type: serializer.fromJson<String>(json['type']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'protocolId': serializer.toJson<int>(protocolId),
      'type': serializer.toJson<String>(type),
      'imagePath': serializer.toJson<String>(imagePath),
    };
  }

  SignaturesTableData copyWith({
    int? id,
    int? protocolId,
    String? type,
    String? imagePath,
  }) => SignaturesTableData(
    id: id ?? this.id,
    protocolId: protocolId ?? this.protocolId,
    type: type ?? this.type,
    imagePath: imagePath ?? this.imagePath,
  );
  SignaturesTableData copyWithCompanion(SignaturesTableCompanion data) {
    return SignaturesTableData(
      id: data.id.present ? data.id.value : this.id,
      protocolId: data.protocolId.present
          ? data.protocolId.value
          : this.protocolId,
      type: data.type.present ? data.type.value : this.type,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SignaturesTableData(')
          ..write('id: $id, ')
          ..write('protocolId: $protocolId, ')
          ..write('type: $type, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, protocolId, type, imagePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SignaturesTableData &&
          other.id == this.id &&
          other.protocolId == this.protocolId &&
          other.type == this.type &&
          other.imagePath == this.imagePath);
}

class SignaturesTableCompanion extends UpdateCompanion<SignaturesTableData> {
  final Value<int> id;
  final Value<int> protocolId;
  final Value<String> type;
  final Value<String> imagePath;
  const SignaturesTableCompanion({
    this.id = const Value.absent(),
    this.protocolId = const Value.absent(),
    this.type = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  SignaturesTableCompanion.insert({
    this.id = const Value.absent(),
    required int protocolId,
    required String type,
    required String imagePath,
  }) : protocolId = Value(protocolId),
       type = Value(type),
       imagePath = Value(imagePath);
  static Insertable<SignaturesTableData> custom({
    Expression<int>? id,
    Expression<int>? protocolId,
    Expression<String>? type,
    Expression<String>? imagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (protocolId != null) 'protocol_id': protocolId,
      if (type != null) 'type': type,
      if (imagePath != null) 'image_path': imagePath,
    });
  }

  SignaturesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? protocolId,
    Value<String>? type,
    Value<String>? imagePath,
  }) {
    return SignaturesTableCompanion(
      id: id ?? this.id,
      protocolId: protocolId ?? this.protocolId,
      type: type ?? this.type,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (protocolId.present) {
      map['protocol_id'] = Variable<int>(protocolId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SignaturesTableCompanion(')
          ..write('id: $id, ')
          ..write('protocolId: $protocolId, ')
          ..write('type: $type, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProtocolsTableTable protocolsTable = $ProtocolsTableTable(this);
  late final $SignaturesTableTable signaturesTable = $SignaturesTableTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    protocolsTable,
    signaturesTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'protocols_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('signatures_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProtocolsTableTableCreateCompanionBuilder =
    ProtocolsTableCompanion Function({
      Value<int> id,
      required String type,
      Value<String?> customerName,
      required int createdAt,
      required int updatedAt,
      required String status,
      required String jsonData,
      Value<String?> pdfPath,
    });
typedef $$ProtocolsTableTableUpdateCompanionBuilder =
    ProtocolsTableCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String?> customerName,
      Value<int> createdAt,
      Value<int> updatedAt,
      Value<String> status,
      Value<String> jsonData,
      Value<String?> pdfPath,
    });

final class $$ProtocolsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProtocolsTableTable,
          ProtocolsTableData
        > {
  $$ProtocolsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$SignaturesTableTable, List<SignaturesTableData>>
  _signaturesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.signaturesTable,
    aliasName: $_aliasNameGenerator(
      db.protocolsTable.id,
      db.signaturesTable.protocolId,
    ),
  );

  $$SignaturesTableTableProcessedTableManager get signaturesTableRefs {
    final manager = $$SignaturesTableTableTableManager(
      $_db,
      $_db.signaturesTable,
    ).filter((f) => f.protocolId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _signaturesTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProtocolsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProtocolsTableTable> {
  $$ProtocolsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> signaturesTableRefs(
    Expression<bool> Function($$SignaturesTableTableFilterComposer f) f,
  ) {
    final $$SignaturesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.signaturesTable,
      getReferencedColumn: (t) => t.protocolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SignaturesTableTableFilterComposer(
            $db: $db,
            $table: $db.signaturesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProtocolsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProtocolsTableTable> {
  $$ProtocolsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pdfPath => $composableBuilder(
    column: $table.pdfPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProtocolsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProtocolsTableTable> {
  $$ProtocolsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);

  GeneratedColumn<String> get pdfPath =>
      $composableBuilder(column: $table.pdfPath, builder: (column) => column);

  Expression<T> signaturesTableRefs<T extends Object>(
    Expression<T> Function($$SignaturesTableTableAnnotationComposer a) f,
  ) {
    final $$SignaturesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.signaturesTable,
      getReferencedColumn: (t) => t.protocolId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SignaturesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.signaturesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProtocolsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProtocolsTableTable,
          ProtocolsTableData,
          $$ProtocolsTableTableFilterComposer,
          $$ProtocolsTableTableOrderingComposer,
          $$ProtocolsTableTableAnnotationComposer,
          $$ProtocolsTableTableCreateCompanionBuilder,
          $$ProtocolsTableTableUpdateCompanionBuilder,
          (ProtocolsTableData, $$ProtocolsTableTableReferences),
          ProtocolsTableData,
          PrefetchHooks Function({bool signaturesTableRefs})
        > {
  $$ProtocolsTableTableTableManager(
    _$AppDatabase db,
    $ProtocolsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProtocolsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProtocolsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProtocolsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> customerName = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> updatedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> jsonData = const Value.absent(),
                Value<String?> pdfPath = const Value.absent(),
              }) => ProtocolsTableCompanion(
                id: id,
                type: type,
                customerName: customerName,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                jsonData: jsonData,
                pdfPath: pdfPath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                Value<String?> customerName = const Value.absent(),
                required int createdAt,
                required int updatedAt,
                required String status,
                required String jsonData,
                Value<String?> pdfPath = const Value.absent(),
              }) => ProtocolsTableCompanion.insert(
                id: id,
                type: type,
                customerName: customerName,
                createdAt: createdAt,
                updatedAt: updatedAt,
                status: status,
                jsonData: jsonData,
                pdfPath: pdfPath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProtocolsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({signaturesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (signaturesTableRefs) db.signaturesTable,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (signaturesTableRefs)
                    await $_getPrefetchedData<
                      ProtocolsTableData,
                      $ProtocolsTableTable,
                      SignaturesTableData
                    >(
                      currentTable: table,
                      referencedTable: $$ProtocolsTableTableReferences
                          ._signaturesTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProtocolsTableTableReferences(
                            db,
                            table,
                            p0,
                          ).signaturesTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.protocolId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProtocolsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProtocolsTableTable,
      ProtocolsTableData,
      $$ProtocolsTableTableFilterComposer,
      $$ProtocolsTableTableOrderingComposer,
      $$ProtocolsTableTableAnnotationComposer,
      $$ProtocolsTableTableCreateCompanionBuilder,
      $$ProtocolsTableTableUpdateCompanionBuilder,
      (ProtocolsTableData, $$ProtocolsTableTableReferences),
      ProtocolsTableData,
      PrefetchHooks Function({bool signaturesTableRefs})
    >;
typedef $$SignaturesTableTableCreateCompanionBuilder =
    SignaturesTableCompanion Function({
      Value<int> id,
      required int protocolId,
      required String type,
      required String imagePath,
    });
typedef $$SignaturesTableTableUpdateCompanionBuilder =
    SignaturesTableCompanion Function({
      Value<int> id,
      Value<int> protocolId,
      Value<String> type,
      Value<String> imagePath,
    });

final class $$SignaturesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SignaturesTableTable,
          SignaturesTableData
        > {
  $$SignaturesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProtocolsTableTable _protocolIdTable(_$AppDatabase db) =>
      db.protocolsTable.createAlias(
        $_aliasNameGenerator(
          db.signaturesTable.protocolId,
          db.protocolsTable.id,
        ),
      );

  $$ProtocolsTableTableProcessedTableManager get protocolId {
    final $_column = $_itemColumn<int>('protocol_id')!;

    final manager = $$ProtocolsTableTableTableManager(
      $_db,
      $_db.protocolsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_protocolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SignaturesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SignaturesTableTable> {
  $$SignaturesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  $$ProtocolsTableTableFilterComposer get protocolId {
    final $$ProtocolsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.protocolId,
      referencedTable: $db.protocolsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProtocolsTableTableFilterComposer(
            $db: $db,
            $table: $db.protocolsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SignaturesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SignaturesTableTable> {
  $$SignaturesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProtocolsTableTableOrderingComposer get protocolId {
    final $$ProtocolsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.protocolId,
      referencedTable: $db.protocolsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProtocolsTableTableOrderingComposer(
            $db: $db,
            $table: $db.protocolsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SignaturesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SignaturesTableTable> {
  $$SignaturesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  $$ProtocolsTableTableAnnotationComposer get protocolId {
    final $$ProtocolsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.protocolId,
      referencedTable: $db.protocolsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProtocolsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.protocolsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SignaturesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SignaturesTableTable,
          SignaturesTableData,
          $$SignaturesTableTableFilterComposer,
          $$SignaturesTableTableOrderingComposer,
          $$SignaturesTableTableAnnotationComposer,
          $$SignaturesTableTableCreateCompanionBuilder,
          $$SignaturesTableTableUpdateCompanionBuilder,
          (SignaturesTableData, $$SignaturesTableTableReferences),
          SignaturesTableData,
          PrefetchHooks Function({bool protocolId})
        > {
  $$SignaturesTableTableTableManager(
    _$AppDatabase db,
    $SignaturesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SignaturesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SignaturesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SignaturesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> protocolId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
              }) => SignaturesTableCompanion(
                id: id,
                protocolId: protocolId,
                type: type,
                imagePath: imagePath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int protocolId,
                required String type,
                required String imagePath,
              }) => SignaturesTableCompanion.insert(
                id: id,
                protocolId: protocolId,
                type: type,
                imagePath: imagePath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SignaturesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({protocolId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (protocolId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.protocolId,
                                referencedTable:
                                    $$SignaturesTableTableReferences
                                        ._protocolIdTable(db),
                                referencedColumn:
                                    $$SignaturesTableTableReferences
                                        ._protocolIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SignaturesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SignaturesTableTable,
      SignaturesTableData,
      $$SignaturesTableTableFilterComposer,
      $$SignaturesTableTableOrderingComposer,
      $$SignaturesTableTableAnnotationComposer,
      $$SignaturesTableTableCreateCompanionBuilder,
      $$SignaturesTableTableUpdateCompanionBuilder,
      (SignaturesTableData, $$SignaturesTableTableReferences),
      SignaturesTableData,
      PrefetchHooks Function({bool protocolId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProtocolsTableTableTableManager get protocolsTable =>
      $$ProtocolsTableTableTableManager(_db, _db.protocolsTable);
  $$SignaturesTableTableTableManager get signaturesTable =>
      $$SignaturesTableTableTableManager(_db, _db.signaturesTable);
}
