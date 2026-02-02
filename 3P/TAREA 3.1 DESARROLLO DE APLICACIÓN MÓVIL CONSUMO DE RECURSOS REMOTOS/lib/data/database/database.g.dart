// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ContactosTable extends Contactos
    with TableInfo<$ContactosTable, Contacto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactosTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _fotoMeta = const VerificationMeta('foto');
  @override
  late final GeneratedColumn<String> foto = GeneratedColumn<String>(
    'foto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _esFavoritoMeta = const VerificationMeta(
    'esFavorito',
  );
  @override
  late final GeneratedColumn<bool> esFavorito = GeneratedColumn<bool>(
    'es_favorito',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("es_favorito" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    descripcion,
    telefono,
    email,
    foto,
    esFavorito,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contactos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contacto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('foto')) {
      context.handle(
        _fotoMeta,
        foto.isAcceptableOrUnknown(data['foto']!, _fotoMeta),
      );
    }
    if (data.containsKey('es_favorito')) {
      context.handle(
        _esFavoritoMeta,
        esFavorito.isAcceptableOrUnknown(data['es_favorito']!, _esFavoritoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contacto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contacto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      foto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}foto'],
      )!,
      esFavorito: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}es_favorito'],
      )!,
    );
  }

  @override
  $ContactosTable createAlias(String alias) {
    return $ContactosTable(attachedDatabase, alias);
  }
}

class Contacto extends DataClass implements Insertable<Contacto> {
  final int id;
  final String nombre;
  final String descripcion;
  final String telefono;
  final String email;
  final String foto;
  final bool esFavorito;
  const Contacto({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.telefono,
    required this.email,
    required this.foto,
    required this.esFavorito,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['telefono'] = Variable<String>(telefono);
    map['email'] = Variable<String>(email);
    map['foto'] = Variable<String>(foto);
    map['es_favorito'] = Variable<bool>(esFavorito);
    return map;
  }

  ContactosCompanion toCompanion(bool nullToAbsent) {
    return ContactosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      telefono: Value(telefono),
      email: Value(email),
      foto: Value(foto),
      esFavorito: Value(esFavorito),
    );
  }

  factory Contacto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contacto(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      telefono: serializer.fromJson<String>(json['telefono']),
      email: serializer.fromJson<String>(json['email']),
      foto: serializer.fromJson<String>(json['foto']),
      esFavorito: serializer.fromJson<bool>(json['esFavorito']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'telefono': serializer.toJson<String>(telefono),
      'email': serializer.toJson<String>(email),
      'foto': serializer.toJson<String>(foto),
      'esFavorito': serializer.toJson<bool>(esFavorito),
    };
  }

  Contacto copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    String? telefono,
    String? email,
    String? foto,
    bool? esFavorito,
  }) => Contacto(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    telefono: telefono ?? this.telefono,
    email: email ?? this.email,
    foto: foto ?? this.foto,
    esFavorito: esFavorito ?? this.esFavorito,
  );
  Contacto copyWithCompanion(ContactosCompanion data) {
    return Contacto(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      email: data.email.present ? data.email.value : this.email,
      foto: data.foto.present ? data.foto.value : this.foto,
      esFavorito: data.esFavorito.present
          ? data.esFavorito.value
          : this.esFavorito,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contacto(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('telefono: $telefono, ')
          ..write('email: $email, ')
          ..write('foto: $foto, ')
          ..write('esFavorito: $esFavorito')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, descripcion, telefono, email, foto, esFavorito);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contacto &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.telefono == this.telefono &&
          other.email == this.email &&
          other.foto == this.foto &&
          other.esFavorito == this.esFavorito);
}

class ContactosCompanion extends UpdateCompanion<Contacto> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<String> telefono;
  final Value<String> email;
  final Value<String> foto;
  final Value<bool> esFavorito;
  const ContactosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.telefono = const Value.absent(),
    this.email = const Value.absent(),
    this.foto = const Value.absent(),
    this.esFavorito = const Value.absent(),
  });
  ContactosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    this.telefono = const Value.absent(),
    this.email = const Value.absent(),
    this.foto = const Value.absent(),
    this.esFavorito = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Contacto> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<String>? telefono,
    Expression<String>? email,
    Expression<String>? foto,
    Expression<bool>? esFavorito,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (telefono != null) 'telefono': telefono,
      if (email != null) 'email': email,
      if (foto != null) 'foto': foto,
      if (esFavorito != null) 'es_favorito': esFavorito,
    });
  }

  ContactosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? descripcion,
    Value<String>? telefono,
    Value<String>? email,
    Value<String>? foto,
    Value<bool>? esFavorito,
  }) {
    return ContactosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      foto: foto ?? this.foto,
      esFavorito: esFavorito ?? this.esFavorito,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (foto.present) {
      map['foto'] = Variable<String>(foto.value);
    }
    if (esFavorito.present) {
      map['es_favorito'] = Variable<bool>(esFavorito.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('telefono: $telefono, ')
          ..write('email: $email, ')
          ..write('foto: $foto, ')
          ..write('esFavorito: $esFavorito')
          ..write(')'))
        .toString();
  }
}

class $GruposTable extends Grupos with TableInfo<$GruposTable, Grupo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GruposTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _iconoMeta = const VerificationMeta('icono');
  @override
  late final GeneratedColumn<String> icono = GeneratedColumn<String>(
    'icono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('group'),
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF4CAF50),
  );
  static const VerificationMeta _contactoIdsMeta = const VerificationMeta(
    'contactoIds',
  );
  @override
  late final GeneratedColumn<String> contactoIds = GeneratedColumn<String>(
    'contacto_ids',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    descripcion,
    icono,
    color,
    contactoIds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'grupos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Grupo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('icono')) {
      context.handle(
        _iconoMeta,
        icono.isAcceptableOrUnknown(data['icono']!, _iconoMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('contacto_ids')) {
      context.handle(
        _contactoIdsMeta,
        contactoIds.isAcceptableOrUnknown(
          data['contacto_ids']!,
          _contactoIdsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Grupo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Grupo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      icono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icono'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      contactoIds: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contacto_ids'],
      )!,
    );
  }

  @override
  $GruposTable createAlias(String alias) {
    return $GruposTable(attachedDatabase, alias);
  }
}

class Grupo extends DataClass implements Insertable<Grupo> {
  final int id;
  final String nombre;
  final String descripcion;
  final String icono;
  final int color;
  final String contactoIds;
  const Grupo({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.icono,
    required this.color,
    required this.contactoIds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['descripcion'] = Variable<String>(descripcion);
    map['icono'] = Variable<String>(icono);
    map['color'] = Variable<int>(color);
    map['contacto_ids'] = Variable<String>(contactoIds);
    return map;
  }

  GruposCompanion toCompanion(bool nullToAbsent) {
    return GruposCompanion(
      id: Value(id),
      nombre: Value(nombre),
      descripcion: Value(descripcion),
      icono: Value(icono),
      color: Value(color),
      contactoIds: Value(contactoIds),
    );
  }

  factory Grupo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Grupo(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      icono: serializer.fromJson<String>(json['icono']),
      color: serializer.fromJson<int>(json['color']),
      contactoIds: serializer.fromJson<String>(json['contactoIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String>(descripcion),
      'icono': serializer.toJson<String>(icono),
      'color': serializer.toJson<int>(color),
      'contactoIds': serializer.toJson<String>(contactoIds),
    };
  }

  Grupo copyWith({
    int? id,
    String? nombre,
    String? descripcion,
    String? icono,
    int? color,
    String? contactoIds,
  }) => Grupo(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion ?? this.descripcion,
    icono: icono ?? this.icono,
    color: color ?? this.color,
    contactoIds: contactoIds ?? this.contactoIds,
  );
  Grupo copyWithCompanion(GruposCompanion data) {
    return Grupo(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      icono: data.icono.present ? data.icono.value : this.icono,
      color: data.color.present ? data.color.value : this.color,
      contactoIds: data.contactoIds.present
          ? data.contactoIds.value
          : this.contactoIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Grupo(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('icono: $icono, ')
          ..write('color: $color, ')
          ..write('contactoIds: $contactoIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, descripcion, icono, color, contactoIds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Grupo &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.icono == this.icono &&
          other.color == this.color &&
          other.contactoIds == this.contactoIds);
}

class GruposCompanion extends UpdateCompanion<Grupo> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> descripcion;
  final Value<String> icono;
  final Value<int> color;
  final Value<String> contactoIds;
  const GruposCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.icono = const Value.absent(),
    this.color = const Value.absent(),
    this.contactoIds = const Value.absent(),
  });
  GruposCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    this.descripcion = const Value.absent(),
    this.icono = const Value.absent(),
    this.color = const Value.absent(),
    this.contactoIds = const Value.absent(),
  }) : nombre = Value(nombre);
  static Insertable<Grupo> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<String>? icono,
    Expression<int>? color,
    Expression<String>? contactoIds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (icono != null) 'icono': icono,
      if (color != null) 'color': color,
      if (contactoIds != null) 'contacto_ids': contactoIds,
    });
  }

  GruposCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? descripcion,
    Value<String>? icono,
    Value<int>? color,
    Value<String>? contactoIds,
  }) {
    return GruposCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      icono: icono ?? this.icono,
      color: color ?? this.color,
      contactoIds: contactoIds ?? this.contactoIds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (icono.present) {
      map['icono'] = Variable<String>(icono.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (contactoIds.present) {
      map['contacto_ids'] = Variable<String>(contactoIds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GruposCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('icono: $icono, ')
          ..write('color: $color, ')
          ..write('contactoIds: $contactoIds')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ContactosTable contactos = $ContactosTable(this);
  late final $GruposTable grupos = $GruposTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [contactos, grupos];
}

typedef $$ContactosTableCreateCompanionBuilder =
    ContactosCompanion Function({
      Value<int> id,
      required String nombre,
      Value<String> descripcion,
      Value<String> telefono,
      Value<String> email,
      Value<String> foto,
      Value<bool> esFavorito,
    });
typedef $$ContactosTableUpdateCompanionBuilder =
    ContactosCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> descripcion,
      Value<String> telefono,
      Value<String> email,
      Value<String> foto,
      Value<bool> esFavorito,
    });

class $$ContactosTableFilterComposer
    extends Composer<_$AppDatabase, $ContactosTable> {
  $$ContactosTableFilterComposer({
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

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foto => $composableBuilder(
    column: $table.foto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get esFavorito => $composableBuilder(
    column: $table.esFavorito,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ContactosTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactosTable> {
  $$ContactosTableOrderingComposer({
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

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foto => $composableBuilder(
    column: $table.foto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get esFavorito => $composableBuilder(
    column: $table.esFavorito,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContactosTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactosTable> {
  $$ContactosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get foto =>
      $composableBuilder(column: $table.foto, builder: (column) => column);

  GeneratedColumn<bool> get esFavorito => $composableBuilder(
    column: $table.esFavorito,
    builder: (column) => column,
  );
}

class $$ContactosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContactosTable,
          Contacto,
          $$ContactosTableFilterComposer,
          $$ContactosTableOrderingComposer,
          $$ContactosTableAnnotationComposer,
          $$ContactosTableCreateCompanionBuilder,
          $$ContactosTableUpdateCompanionBuilder,
          (Contacto, BaseReferences<_$AppDatabase, $ContactosTable, Contacto>),
          Contacto,
          PrefetchHooks Function()
        > {
  $$ContactosTableTableManager(_$AppDatabase db, $ContactosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> foto = const Value.absent(),
                Value<bool> esFavorito = const Value.absent(),
              }) => ContactosCompanion(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                telefono: telefono,
                email: email,
                foto: foto,
                esFavorito: esFavorito,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String> descripcion = const Value.absent(),
                Value<String> telefono = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> foto = const Value.absent(),
                Value<bool> esFavorito = const Value.absent(),
              }) => ContactosCompanion.insert(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                telefono: telefono,
                email: email,
                foto: foto,
                esFavorito: esFavorito,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ContactosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContactosTable,
      Contacto,
      $$ContactosTableFilterComposer,
      $$ContactosTableOrderingComposer,
      $$ContactosTableAnnotationComposer,
      $$ContactosTableCreateCompanionBuilder,
      $$ContactosTableUpdateCompanionBuilder,
      (Contacto, BaseReferences<_$AppDatabase, $ContactosTable, Contacto>),
      Contacto,
      PrefetchHooks Function()
    >;
typedef $$GruposTableCreateCompanionBuilder =
    GruposCompanion Function({
      Value<int> id,
      required String nombre,
      Value<String> descripcion,
      Value<String> icono,
      Value<int> color,
      Value<String> contactoIds,
    });
typedef $$GruposTableUpdateCompanionBuilder =
    GruposCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> descripcion,
      Value<String> icono,
      Value<int> color,
      Value<String> contactoIds,
    });

class $$GruposTableFilterComposer
    extends Composer<_$AppDatabase, $GruposTable> {
  $$GruposTableFilterComposer({
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

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icono => $composableBuilder(
    column: $table.icono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactoIds => $composableBuilder(
    column: $table.contactoIds,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GruposTableOrderingComposer
    extends Composer<_$AppDatabase, $GruposTable> {
  $$GruposTableOrderingComposer({
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

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icono => $composableBuilder(
    column: $table.icono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactoIds => $composableBuilder(
    column: $table.contactoIds,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GruposTableAnnotationComposer
    extends Composer<_$AppDatabase, $GruposTable> {
  $$GruposTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icono =>
      $composableBuilder(column: $table.icono, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get contactoIds => $composableBuilder(
    column: $table.contactoIds,
    builder: (column) => column,
  );
}

class $$GruposTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GruposTable,
          Grupo,
          $$GruposTableFilterComposer,
          $$GruposTableOrderingComposer,
          $$GruposTableAnnotationComposer,
          $$GruposTableCreateCompanionBuilder,
          $$GruposTableUpdateCompanionBuilder,
          (Grupo, BaseReferences<_$AppDatabase, $GruposTable, Grupo>),
          Grupo,
          PrefetchHooks Function()
        > {
  $$GruposTableTableManager(_$AppDatabase db, $GruposTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GruposTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GruposTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GruposTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<String> icono = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<String> contactoIds = const Value.absent(),
              }) => GruposCompanion(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                icono: icono,
                color: color,
                contactoIds: contactoIds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                Value<String> descripcion = const Value.absent(),
                Value<String> icono = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<String> contactoIds = const Value.absent(),
              }) => GruposCompanion.insert(
                id: id,
                nombre: nombre,
                descripcion: descripcion,
                icono: icono,
                color: color,
                contactoIds: contactoIds,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GruposTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GruposTable,
      Grupo,
      $$GruposTableFilterComposer,
      $$GruposTableOrderingComposer,
      $$GruposTableAnnotationComposer,
      $$GruposTableCreateCompanionBuilder,
      $$GruposTableUpdateCompanionBuilder,
      (Grupo, BaseReferences<_$AppDatabase, $GruposTable, Grupo>),
      Grupo,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ContactosTableTableManager get contactos =>
      $$ContactosTableTableManager(_db, _db.contactos);
  $$GruposTableTableManager get grupos =>
      $$GruposTableTableManager(_db, _db.grupos);
}
