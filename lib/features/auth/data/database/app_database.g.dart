// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _dobMeta = const VerificationMeta('dob');
  @override
  late final GeneratedColumn<DateTime> dob = GeneratedColumn<DateTime>(
    'dob',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentPointsMeta = const VerificationMeta(
    'currentPoints',
  );
  @override
  late final GeneratedColumn<int> currentPoints = GeneratedColumn<int>(
    'current_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _memberIdMeta = const VerificationMeta(
    'memberId',
  );
  @override
  late final GeneratedColumn<int> memberId = GeneratedColumn<int>(
    'member_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    phone,
    dob,
    currentPoints,
    memberId,
    isVerified,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('dob')) {
      context.handle(
        _dobMeta,
        dob.isAcceptableOrUnknown(data['dob']!, _dobMeta),
      );
    }
    if (data.containsKey('current_points')) {
      context.handle(
        _currentPointsMeta,
        currentPoints.isAcceptableOrUnknown(
          data['current_points']!,
          _currentPointsMeta,
        ),
      );
    }
    if (data.containsKey('member_id')) {
      context.handle(
        _memberIdMeta,
        memberId.isAcceptableOrUnknown(data['member_id']!, _memberIdMeta),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      dob: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dob'],
      ),
      currentPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_points'],
      )!,
      memberId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_id'],
      )!,
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final DateTime? dob;
  final int currentPoints;
  final int memberId;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    this.dob,
    required this.currentPoints,
    required this.memberId,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || dob != null) {
      map['dob'] = Variable<DateTime>(dob);
    }
    map['current_points'] = Variable<int>(currentPoints);
    map['member_id'] = Variable<int>(memberId);
    map['is_verified'] = Variable<bool>(isVerified);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      phone: Value(phone),
      dob: dob == null && nullToAbsent ? const Value.absent() : Value(dob),
      currentPoints: Value(currentPoints),
      memberId: Value(memberId),
      isVerified: Value(isVerified),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      phone: serializer.fromJson<String>(json['phone']),
      dob: serializer.fromJson<DateTime?>(json['dob']),
      currentPoints: serializer.fromJson<int>(json['currentPoints']),
      memberId: serializer.fromJson<int>(json['memberId']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'phone': serializer.toJson<String>(phone),
      'dob': serializer.toJson<DateTime?>(dob),
      'currentPoints': serializer.toJson<int>(currentPoints),
      'memberId': serializer.toJson<int>(memberId),
      'isVerified': serializer.toJson<bool>(isVerified),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    Value<DateTime?> dob = const Value.absent(),
    int? currentPoints,
    int? memberId,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => User(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    phone: phone ?? this.phone,
    dob: dob.present ? dob.value : this.dob,
    currentPoints: currentPoints ?? this.currentPoints,
    memberId: memberId ?? this.memberId,
    isVerified: isVerified ?? this.isVerified,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      phone: data.phone.present ? data.phone.value : this.phone,
      dob: data.dob.present ? data.dob.value : this.dob,
      currentPoints: data.currentPoints.present
          ? data.currentPoints.value
          : this.currentPoints,
      memberId: data.memberId.present ? data.memberId.value : this.memberId,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('phone: $phone, ')
          ..write('dob: $dob, ')
          ..write('currentPoints: $currentPoints, ')
          ..write('memberId: $memberId, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    firstName,
    lastName,
    phone,
    dob,
    currentPoints,
    memberId,
    isVerified,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.phone == this.phone &&
          other.dob == this.dob &&
          other.currentPoints == this.currentPoints &&
          other.memberId == this.memberId &&
          other.isVerified == this.isVerified &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> phone;
  final Value<DateTime?> dob;
  final Value<int> currentPoints;
  final Value<int> memberId;
  final Value<bool> isVerified;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.phone = const Value.absent(),
    this.dob = const Value.absent(),
    this.currentPoints = const Value.absent(),
    this.memberId = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.phone = const Value.absent(),
    this.dob = const Value.absent(),
    this.currentPoints = const Value.absent(),
    this.memberId = const Value.absent(),
    this.isVerified = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? phone,
    Expression<DateTime>? dob,
    Expression<int>? currentPoints,
    Expression<int>? memberId,
    Expression<bool>? isVerified,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (phone != null) 'phone': phone,
      if (dob != null) 'dob': dob,
      if (currentPoints != null) 'current_points': currentPoints,
      if (memberId != null) 'member_id': memberId,
      if (isVerified != null) 'is_verified': isVerified,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? phone,
    Value<DateTime?>? dob,
    Value<int>? currentPoints,
    Value<int>? memberId,
    Value<bool>? isVerified,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      dob: dob ?? this.dob,
      currentPoints: currentPoints ?? this.currentPoints,
      memberId: memberId ?? this.memberId,
      isVerified: isVerified ?? this.isVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (dob.present) {
      map['dob'] = Variable<DateTime>(dob.value);
    }
    if (currentPoints.present) {
      map['current_points'] = Variable<int>(currentPoints.value);
    }
    if (memberId.present) {
      map['member_id'] = Variable<int>(memberId.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('phone: $phone, ')
          ..write('dob: $dob, ')
          ..write('currentPoints: $currentPoints, ')
          ..write('memberId: $memberId, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MembersTable extends Members with TableInfo<$MembersTable, Member> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MembersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _memberPointsMeta = const VerificationMeta(
    'memberPoints',
  );
  @override
  late final GeneratedColumn<int> memberPoints = GeneratedColumn<int>(
    'member_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    imageUrl,
    memberPoints,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'members';
  @override
  VerificationContext validateIntegrity(
    Insertable<Member> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('member_points')) {
      context.handle(
        _memberPointsMeta,
        memberPoints.isAcceptableOrUnknown(
          data['member_points']!,
          _memberPointsMeta,
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Member map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Member(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      memberPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}member_points'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MembersTable createAlias(String alias) {
    return $MembersTable(attachedDatabase, alias);
  }
}

class Member extends DataClass implements Insertable<Member> {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int memberPoints;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Member({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.memberPoints,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['image_url'] = Variable<String>(imageUrl);
    map['member_points'] = Variable<int>(memberPoints);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MembersCompanion toCompanion(bool nullToAbsent) {
    return MembersCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      imageUrl: Value(imageUrl),
      memberPoints: Value(memberPoints),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Member.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Member(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      memberPoints: serializer.fromJson<int>(json['memberPoints']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'memberPoints': serializer.toJson<int>(memberPoints),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Member copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    int? memberPoints,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Member(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    memberPoints: memberPoints ?? this.memberPoints,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Member copyWithCompanion(MembersCompanion data) {
    return Member(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      memberPoints: data.memberPoints.present
          ? data.memberPoints.value
          : this.memberPoints,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Member(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('memberPoints: $memberPoints, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    imageUrl,
    memberPoints,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Member &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.memberPoints == this.memberPoints &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MembersCompanion extends UpdateCompanion<Member> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> imageUrl;
  final Value<int> memberPoints;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MembersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.memberPoints = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MembersCompanion.insert({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.memberPoints = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Member> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<int>? memberPoints,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (memberPoints != null) 'member_points': memberPoints,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MembersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? imageUrl,
    Value<int>? memberPoints,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MembersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      memberPoints: memberPoints ?? this.memberPoints,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (memberPoints.present) {
      map['member_points'] = Variable<int>(memberPoints.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MembersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('memberPoints: $memberPoints, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ProductTypesTable extends ProductTypes
    with TableInfo<$ProductTypesTable, ProductType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductTypesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityNoMeta = const VerificationMeta(
    'priorityNo',
  );
  @override
  late final GeneratedColumn<int> priorityNo = GeneratedColumn<int>(
    'priority_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, imageUrl, priorityNo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_types';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductType> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('priority_no')) {
      context.handle(
        _priorityNoMeta,
        priorityNo.isAcceptableOrUnknown(data['priority_no']!, _priorityNoMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityNoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductType(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      priorityNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority_no'],
      )!,
    );
  }

  @override
  $ProductTypesTable createAlias(String alias) {
    return $ProductTypesTable(attachedDatabase, alias);
  }
}

class ProductType extends DataClass implements Insertable<ProductType> {
  final int id;
  final String name;
  final String imageUrl;
  final int priorityNo;
  const ProductType({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.priorityNo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    map['priority_no'] = Variable<int>(priorityNo);
    return map;
  }

  ProductTypesCompanion toCompanion(bool nullToAbsent) {
    return ProductTypesCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: Value(imageUrl),
      priorityNo: Value(priorityNo),
    );
  }

  factory ProductType.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductType(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      priorityNo: serializer.fromJson<int>(json['priorityNo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'priorityNo': serializer.toJson<int>(priorityNo),
    };
  }

  ProductType copyWith({
    int? id,
    String? name,
    String? imageUrl,
    int? priorityNo,
  }) => ProductType(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
    priorityNo: priorityNo ?? this.priorityNo,
  );
  ProductType copyWithCompanion(ProductTypesCompanion data) {
    return ProductType(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      priorityNo: data.priorityNo.present
          ? data.priorityNo.value
          : this.priorityNo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductType(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('priorityNo: $priorityNo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, imageUrl, priorityNo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductType &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.priorityNo == this.priorityNo);
}

class ProductTypesCompanion extends UpdateCompanion<ProductType> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<int> priorityNo;
  const ProductTypesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.priorityNo = const Value.absent(),
  });
  ProductTypesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String imageUrl,
    required int priorityNo,
  }) : name = Value(name),
       imageUrl = Value(imageUrl),
       priorityNo = Value(priorityNo);
  static Insertable<ProductType> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<int>? priorityNo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (priorityNo != null) 'priority_no': priorityNo,
    });
  }

  ProductTypesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? imageUrl,
    Value<int>? priorityNo,
  }) {
    return ProductTypesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      priorityNo: priorityNo ?? this.priorityNo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (priorityNo.present) {
      map['priority_no'] = Variable<int>(priorityNo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductTypesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('priorityNo: $priorityNo')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityNoMeta = const VerificationMeta(
    'priorityNo',
  );
  @override
  late final GeneratedColumn<int> priorityNo = GeneratedColumn<int>(
    'priority_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productCodeMeta = const VerificationMeta(
    'productCode',
  );
  @override
  late final GeneratedColumn<String> productCode = GeneratedColumn<String>(
    'product_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_new" IN (0, 1))',
    ),
  );
  static const VerificationMeta _discountPercentageMeta =
      const VerificationMeta('discountPercentage');
  @override
  late final GeneratedColumn<double> discountPercentage =
      GeneratedColumn<double>(
        'discount_percentage',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _discountAmountMeta = const VerificationMeta(
    'discountAmount',
  );
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
    'discount_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productTypeIdMeta = const VerificationMeta(
    'productTypeId',
  );
  @override
  late final GeneratedColumn<int> productTypeId = GeneratedColumn<int>(
    'product_type_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES product_types (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    imageUrl,
    priorityNo,
    price,
    currency,
    productCode,
    description,
    isNew,
    discountPercentage,
    discountAmount,
    productTypeId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('priority_no')) {
      context.handle(
        _priorityNoMeta,
        priorityNo.isAcceptableOrUnknown(data['priority_no']!, _priorityNoMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityNoMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('product_code')) {
      context.handle(
        _productCodeMeta,
        productCode.isAcceptableOrUnknown(
          data['product_code']!,
          _productCodeMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    } else if (isInserting) {
      context.missing(_isNewMeta);
    }
    if (data.containsKey('discount_percentage')) {
      context.handle(
        _discountPercentageMeta,
        discountPercentage.isAcceptableOrUnknown(
          data['discount_percentage']!,
          _discountPercentageMeta,
        ),
      );
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
        _discountAmountMeta,
        discountAmount.isAcceptableOrUnknown(
          data['discount_amount']!,
          _discountAmountMeta,
        ),
      );
    }
    if (data.containsKey('product_type_id')) {
      context.handle(
        _productTypeIdMeta,
        productTypeId.isAcceptableOrUnknown(
          data['product_type_id']!,
          _productTypeIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productTypeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      priorityNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority_no'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      ),
      productCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_code'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_new'],
      )!,
      discountPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_percentage'],
      ),
      discountAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_amount'],
      ),
      productTypeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_type_id'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final int id;
  final String name;
  final String imageUrl;
  final int priorityNo;
  final double? price;
  final String? currency;
  final String? productCode;
  final String? description;
  final bool isNew;
  final double? discountPercentage;
  final double? discountAmount;
  final int productTypeId;
  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.priorityNo,
    this.price,
    this.currency,
    this.productCode,
    this.description,
    required this.isNew,
    this.discountPercentage,
    this.discountAmount,
    required this.productTypeId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    map['priority_no'] = Variable<int>(priorityNo);
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    if (!nullToAbsent || currency != null) {
      map['currency'] = Variable<String>(currency);
    }
    if (!nullToAbsent || productCode != null) {
      map['product_code'] = Variable<String>(productCode);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_new'] = Variable<bool>(isNew);
    if (!nullToAbsent || discountPercentage != null) {
      map['discount_percentage'] = Variable<double>(discountPercentage);
    }
    if (!nullToAbsent || discountAmount != null) {
      map['discount_amount'] = Variable<double>(discountAmount);
    }
    map['product_type_id'] = Variable<int>(productTypeId);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: Value(imageUrl),
      priorityNo: Value(priorityNo),
      price: price == null && nullToAbsent
          ? const Value.absent()
          : Value(price),
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
      productCode: productCode == null && nullToAbsent
          ? const Value.absent()
          : Value(productCode),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isNew: Value(isNew),
      discountPercentage: discountPercentage == null && nullToAbsent
          ? const Value.absent()
          : Value(discountPercentage),
      discountAmount: discountAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(discountAmount),
      productTypeId: Value(productTypeId),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      priorityNo: serializer.fromJson<int>(json['priorityNo']),
      price: serializer.fromJson<double?>(json['price']),
      currency: serializer.fromJson<String?>(json['currency']),
      productCode: serializer.fromJson<String?>(json['productCode']),
      description: serializer.fromJson<String?>(json['description']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      discountPercentage: serializer.fromJson<double?>(
        json['discountPercentage'],
      ),
      discountAmount: serializer.fromJson<double?>(json['discountAmount']),
      productTypeId: serializer.fromJson<int>(json['productTypeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'priorityNo': serializer.toJson<int>(priorityNo),
      'price': serializer.toJson<double?>(price),
      'currency': serializer.toJson<String?>(currency),
      'productCode': serializer.toJson<String?>(productCode),
      'description': serializer.toJson<String?>(description),
      'isNew': serializer.toJson<bool>(isNew),
      'discountPercentage': serializer.toJson<double?>(discountPercentage),
      'discountAmount': serializer.toJson<double?>(discountAmount),
      'productTypeId': serializer.toJson<int>(productTypeId),
    };
  }

  Product copyWith({
    int? id,
    String? name,
    String? imageUrl,
    int? priorityNo,
    Value<double?> price = const Value.absent(),
    Value<String?> currency = const Value.absent(),
    Value<String?> productCode = const Value.absent(),
    Value<String?> description = const Value.absent(),
    bool? isNew,
    Value<double?> discountPercentage = const Value.absent(),
    Value<double?> discountAmount = const Value.absent(),
    int? productTypeId,
  }) => Product(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
    priorityNo: priorityNo ?? this.priorityNo,
    price: price.present ? price.value : this.price,
    currency: currency.present ? currency.value : this.currency,
    productCode: productCode.present ? productCode.value : this.productCode,
    description: description.present ? description.value : this.description,
    isNew: isNew ?? this.isNew,
    discountPercentage: discountPercentage.present
        ? discountPercentage.value
        : this.discountPercentage,
    discountAmount: discountAmount.present
        ? discountAmount.value
        : this.discountAmount,
    productTypeId: productTypeId ?? this.productTypeId,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      priorityNo: data.priorityNo.present
          ? data.priorityNo.value
          : this.priorityNo,
      price: data.price.present ? data.price.value : this.price,
      currency: data.currency.present ? data.currency.value : this.currency,
      productCode: data.productCode.present
          ? data.productCode.value
          : this.productCode,
      description: data.description.present
          ? data.description.value
          : this.description,
      isNew: data.isNew.present ? data.isNew.value : this.isNew,
      discountPercentage: data.discountPercentage.present
          ? data.discountPercentage.value
          : this.discountPercentage,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      productTypeId: data.productTypeId.present
          ? data.productTypeId.value
          : this.productTypeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('priorityNo: $priorityNo, ')
          ..write('price: $price, ')
          ..write('currency: $currency, ')
          ..write('productCode: $productCode, ')
          ..write('description: $description, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('productTypeId: $productTypeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    imageUrl,
    priorityNo,
    price,
    currency,
    productCode,
    description,
    isNew,
    discountPercentage,
    discountAmount,
    productTypeId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.priorityNo == this.priorityNo &&
          other.price == this.price &&
          other.currency == this.currency &&
          other.productCode == this.productCode &&
          other.description == this.description &&
          other.isNew == this.isNew &&
          other.discountPercentage == this.discountPercentage &&
          other.discountAmount == this.discountAmount &&
          other.productTypeId == this.productTypeId);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<int> priorityNo;
  final Value<double?> price;
  final Value<String?> currency;
  final Value<String?> productCode;
  final Value<String?> description;
  final Value<bool> isNew;
  final Value<double?> discountPercentage;
  final Value<double?> discountAmount;
  final Value<int> productTypeId;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.priorityNo = const Value.absent(),
    this.price = const Value.absent(),
    this.currency = const Value.absent(),
    this.productCode = const Value.absent(),
    this.description = const Value.absent(),
    this.isNew = const Value.absent(),
    this.discountPercentage = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.productTypeId = const Value.absent(),
  });
  ProductsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String imageUrl,
    required int priorityNo,
    this.price = const Value.absent(),
    this.currency = const Value.absent(),
    this.productCode = const Value.absent(),
    this.description = const Value.absent(),
    required bool isNew,
    this.discountPercentage = const Value.absent(),
    this.discountAmount = const Value.absent(),
    required int productTypeId,
  }) : name = Value(name),
       imageUrl = Value(imageUrl),
       priorityNo = Value(priorityNo),
       isNew = Value(isNew),
       productTypeId = Value(productTypeId);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<int>? priorityNo,
    Expression<double>? price,
    Expression<String>? currency,
    Expression<String>? productCode,
    Expression<String>? description,
    Expression<bool>? isNew,
    Expression<double>? discountPercentage,
    Expression<double>? discountAmount,
    Expression<int>? productTypeId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (priorityNo != null) 'priority_no': priorityNo,
      if (price != null) 'price': price,
      if (currency != null) 'currency': currency,
      if (productCode != null) 'product_code': productCode,
      if (description != null) 'description': description,
      if (isNew != null) 'is_new': isNew,
      if (discountPercentage != null) 'discount_percentage': discountPercentage,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (productTypeId != null) 'product_type_id': productTypeId,
    });
  }

  ProductsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? imageUrl,
    Value<int>? priorityNo,
    Value<double?>? price,
    Value<String?>? currency,
    Value<String?>? productCode,
    Value<String?>? description,
    Value<bool>? isNew,
    Value<double?>? discountPercentage,
    Value<double?>? discountAmount,
    Value<int>? productTypeId,
  }) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      priorityNo: priorityNo ?? this.priorityNo,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      productCode: productCode ?? this.productCode,
      description: description ?? this.description,
      isNew: isNew ?? this.isNew,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountAmount: discountAmount ?? this.discountAmount,
      productTypeId: productTypeId ?? this.productTypeId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (priorityNo.present) {
      map['priority_no'] = Variable<int>(priorityNo.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (productCode.present) {
      map['product_code'] = Variable<String>(productCode.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (discountPercentage.present) {
      map['discount_percentage'] = Variable<double>(discountPercentage.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
    }
    if (productTypeId.present) {
      map['product_type_id'] = Variable<int>(productTypeId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('priorityNo: $priorityNo, ')
          ..write('price: $price, ')
          ..write('currency: $currency, ')
          ..write('productCode: $productCode, ')
          ..write('description: $description, ')
          ..write('isNew: $isNew, ')
          ..write('discountPercentage: $discountPercentage, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('productTypeId: $productTypeId')
          ..write(')'))
        .toString();
  }
}

class $BannersTable extends Banners with TableInfo<$BannersTable, Banner> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BannersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, imageUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'banners';
  @override
  VerificationContext validateIntegrity(
    Insertable<Banner> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Banner map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Banner(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
    );
  }

  @override
  $BannersTable createAlias(String alias) {
    return $BannersTable(attachedDatabase, alias);
  }
}

class Banner extends DataClass implements Insertable<Banner> {
  final int id;
  final String name;
  final String imageUrl;
  const Banner({required this.id, required this.name, required this.imageUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    return map;
  }

  BannersCompanion toCompanion(bool nullToAbsent) {
    return BannersCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: Value(imageUrl),
    );
  }

  factory Banner.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Banner(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
    };
  }

  Banner copyWith({int? id, String? name, String? imageUrl}) => Banner(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
  );
  Banner copyWithCompanion(BannersCompanion data) {
    return Banner(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Banner(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Banner &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl);
}

class BannersCompanion extends UpdateCompanion<Banner> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageUrl;
  const BannersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
  });
  BannersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String imageUrl,
  }) : name = Value(name),
       imageUrl = Value(imageUrl);
  static Insertable<Banner> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
    });
  }

  BannersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? imageUrl,
  }) {
    return BannersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BannersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }
}

class $ShopsTable extends Shops with TableInfo<$ShopsTable, Shop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    address,
    imageUrl,
    lat,
    lng,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops';
  @override
  VerificationContext validateIntegrity(
    Insertable<Shop> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shop map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shop(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lng: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lng'],
      )!,
    );
  }

  @override
  $ShopsTable createAlias(String alias) {
    return $ShopsTable(attachedDatabase, alias);
  }
}

class Shop extends DataClass implements Insertable<Shop> {
  final int id;
  final String name;
  final String description;
  final String address;
  final String imageUrl;
  final double lat;
  final double lng;
  const Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.imageUrl,
    required this.lat,
    required this.lng,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['address'] = Variable<String>(address);
    map['image_url'] = Variable<String>(imageUrl);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    return map;
  }

  ShopsCompanion toCompanion(bool nullToAbsent) {
    return ShopsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      address: Value(address),
      imageUrl: Value(imageUrl),
      lat: Value(lat),
      lng: Value(lng),
    );
  }

  factory Shop.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shop(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      address: serializer.fromJson<String>(json['address']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'address': serializer.toJson<String>(address),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
    };
  }

  Shop copyWith({
    int? id,
    String? name,
    String? description,
    String? address,
    String? imageUrl,
    double? lat,
    double? lng,
  }) => Shop(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    address: address ?? this.address,
    imageUrl: imageUrl ?? this.imageUrl,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
  );
  Shop copyWithCompanion(ShopsCompanion data) {
    return Shop(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      address: data.address.present ? data.address.value : this.address,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shop(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('address: $address, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, address, imageUrl, lat, lng);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shop &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.address == this.address &&
          other.imageUrl == this.imageUrl &&
          other.lat == this.lat &&
          other.lng == this.lng);
}

class ShopsCompanion extends UpdateCompanion<Shop> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> address;
  final Value<String> imageUrl;
  final Value<double> lat;
  final Value<double> lng;
  const ShopsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.address = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
  });
  ShopsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required String address,
    required String imageUrl,
    required double lat,
    required double lng,
  }) : name = Value(name),
       description = Value(description),
       address = Value(address),
       imageUrl = Value(imageUrl),
       lat = Value(lat),
       lng = Value(lng);
  static Insertable<Shop> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? address,
    Expression<String>? imageUrl,
    Expression<double>? lat,
    Expression<double>? lng,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (address != null) 'address': address,
      if (imageUrl != null) 'image_url': imageUrl,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    });
  }

  ShopsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? address,
    Value<String>? imageUrl,
    Value<double>? lat,
    Value<double>? lng,
  }) {
    return ShopsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('address: $address, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityNoMeta = const VerificationMeta(
    'priorityNo',
  );
  @override
  late final GeneratedColumn<int> priorityNo = GeneratedColumn<int>(
    'priority_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    imageUrl,
    priorityNo,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('priority_no')) {
      context.handle(
        _priorityNoMeta,
        priorityNo.isAcceptableOrUnknown(data['priority_no']!, _priorityNoMeta),
      );
    } else if (isInserting) {
      context.missing(_priorityNoMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      priorityNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority_no'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final String imageUrl;
  final int priorityNo;
  final bool isActive;
  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.priorityNo,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    map['priority_no'] = Variable<int>(priorityNo);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: Value(imageUrl),
      priorityNo: Value(priorityNo),
      isActive: Value(isActive),
    );
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      priorityNo: serializer.fromJson<int>(json['priorityNo']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'priorityNo': serializer.toJson<int>(priorityNo),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Category copyWith({
    int? id,
    String? name,
    String? imageUrl,
    int? priorityNo,
    bool? isActive,
  }) => Category(
    id: id ?? this.id,
    name: name ?? this.name,
    imageUrl: imageUrl ?? this.imageUrl,
    priorityNo: priorityNo ?? this.priorityNo,
    isActive: isActive ?? this.isActive,
  );
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      priorityNo: data.priorityNo.present
          ? data.priorityNo.value
          : this.priorityNo,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('priorityNo: $priorityNo, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, imageUrl, priorityNo, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.priorityNo == this.priorityNo &&
          other.isActive == this.isActive);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<int> priorityNo;
  final Value<bool> isActive;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.priorityNo = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String imageUrl,
    required int priorityNo,
    required bool isActive,
  }) : name = Value(name),
       imageUrl = Value(imageUrl),
       priorityNo = Value(priorityNo),
       isActive = Value(isActive);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<int>? priorityNo,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (priorityNo != null) 'priority_no': priorityNo,
      if (isActive != null) 'is_active': isActive,
    });
  }

  CategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? imageUrl,
    Value<int>? priorityNo,
    Value<bool>? isActive,
  }) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      priorityNo: priorityNo ?? this.priorityNo,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (priorityNo.present) {
      map['priority_no'] = Variable<int>(priorityNo.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('priorityNo: $priorityNo, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $CategoryProductsTable extends CategoryProducts
    with TableInfo<$CategoryProductsTable, CategoryProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryProductsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categories (id)',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, categoryId, productId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {categoryId, productId},
  ];
  @override
  CategoryProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryProduct(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
    );
  }

  @override
  $CategoryProductsTable createAlias(String alias) {
    return $CategoryProductsTable(attachedDatabase, alias);
  }
}

class CategoryProduct extends DataClass implements Insertable<CategoryProduct> {
  final int id;
  final int categoryId;
  final int productId;
  const CategoryProduct({
    required this.id,
    required this.categoryId,
    required this.productId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['product_id'] = Variable<int>(productId);
    return map;
  }

  CategoryProductsCompanion toCompanion(bool nullToAbsent) {
    return CategoryProductsCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      productId: Value(productId),
    );
  }

  factory CategoryProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryProduct(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      productId: serializer.fromJson<int>(json['productId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'productId': serializer.toJson<int>(productId),
    };
  }

  CategoryProduct copyWith({int? id, int? categoryId, int? productId}) =>
      CategoryProduct(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        productId: productId ?? this.productId,
      );
  CategoryProduct copyWithCompanion(CategoryProductsCompanion data) {
    return CategoryProduct(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      productId: data.productId.present ? data.productId.value : this.productId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryProduct(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryId, productId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryProduct &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.productId == this.productId);
}

class CategoryProductsCompanion extends UpdateCompanion<CategoryProduct> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<int> productId;
  const CategoryProductsCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.productId = const Value.absent(),
  });
  CategoryProductsCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required int productId,
  }) : categoryId = Value(categoryId),
       productId = Value(productId);
  static Insertable<CategoryProduct> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<int>? productId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (productId != null) 'product_id': productId,
    });
  }

  CategoryProductsCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<int>? productId,
  }) {
    return CategoryProductsCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      productId: productId ?? this.productId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryProductsCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('productId: $productId')
          ..write(')'))
        .toString();
  }
}

class $RewardsTable extends Rewards with TableInfo<$RewardsTable, RewardRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RewardsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorCodeMeta = const VerificationMeta(
    'colorCode',
  );
  @override
  late final GeneratedColumn<String> colorCode = GeneratedColumn<String>(
    'color_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardPointsMeta = const VerificationMeta(
    'rewardPoints',
  );
  @override
  late final GeneratedColumn<int> rewardPoints = GeneratedColumn<int>(
    'reward_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (reward_points >= 0)',
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    imageUrl,
    colorCode,
    rewardPoints,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rewards';
  @override
  VerificationContext validateIntegrity(
    Insertable<RewardRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('color_code')) {
      context.handle(
        _colorCodeMeta,
        colorCode.isAcceptableOrUnknown(data['color_code']!, _colorCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_colorCodeMeta);
    }
    if (data.containsKey('reward_points')) {
      context.handle(
        _rewardPointsMeta,
        rewardPoints.isAcceptableOrUnknown(
          data['reward_points']!,
          _rewardPointsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rewardPointsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RewardRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RewardRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      colorCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_code'],
      )!,
      rewardPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reward_points'],
      )!,
    );
  }

  @override
  $RewardsTable createAlias(String alias) {
    return $RewardsTable(attachedDatabase, alias);
  }
}

class RewardRow extends DataClass implements Insertable<RewardRow> {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String colorCode;
  final int rewardPoints;
  const RewardRow({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.colorCode,
    required this.rewardPoints,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['image_url'] = Variable<String>(imageUrl);
    map['color_code'] = Variable<String>(colorCode);
    map['reward_points'] = Variable<int>(rewardPoints);
    return map;
  }

  RewardsCompanion toCompanion(bool nullToAbsent) {
    return RewardsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      imageUrl: Value(imageUrl),
      colorCode: Value(colorCode),
      rewardPoints: Value(rewardPoints),
    );
  }

  factory RewardRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RewardRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      colorCode: serializer.fromJson<String>(json['colorCode']),
      rewardPoints: serializer.fromJson<int>(json['rewardPoints']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'colorCode': serializer.toJson<String>(colorCode),
      'rewardPoints': serializer.toJson<int>(rewardPoints),
    };
  }

  RewardRow copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    String? colorCode,
    int? rewardPoints,
  }) => RewardRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    colorCode: colorCode ?? this.colorCode,
    rewardPoints: rewardPoints ?? this.rewardPoints,
  );
  RewardRow copyWithCompanion(RewardsCompanion data) {
    return RewardRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      colorCode: data.colorCode.present ? data.colorCode.value : this.colorCode,
      rewardPoints: data.rewardPoints.present
          ? data.rewardPoints.value
          : this.rewardPoints,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RewardRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('colorCode: $colorCode, ')
          ..write('rewardPoints: $rewardPoints')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, imageUrl, colorCode, rewardPoints);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RewardRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.colorCode == this.colorCode &&
          other.rewardPoints == this.rewardPoints);
}

class RewardsCompanion extends UpdateCompanion<RewardRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> imageUrl;
  final Value<String> colorCode;
  final Value<int> rewardPoints;
  const RewardsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.colorCode = const Value.absent(),
    this.rewardPoints = const Value.absent(),
  });
  RewardsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required String imageUrl,
    required String colorCode,
    required int rewardPoints,
  }) : name = Value(name),
       description = Value(description),
       imageUrl = Value(imageUrl),
       colorCode = Value(colorCode),
       rewardPoints = Value(rewardPoints);
  static Insertable<RewardRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<String>? colorCode,
    Expression<int>? rewardPoints,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (colorCode != null) 'color_code': colorCode,
      if (rewardPoints != null) 'reward_points': rewardPoints,
    });
  }

  RewardsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? imageUrl,
    Value<String>? colorCode,
    Value<int>? rewardPoints,
  }) {
    return RewardsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      colorCode: colorCode ?? this.colorCode,
      rewardPoints: rewardPoints ?? this.rewardPoints,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (colorCode.present) {
      map['color_code'] = Variable<String>(colorCode.value);
    }
    if (rewardPoints.present) {
      map['reward_points'] = Variable<int>(rewardPoints.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RewardsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('colorCode: $colorCode, ')
          ..write('rewardPoints: $rewardPoints')
          ..write(')'))
        .toString();
  }
}

class $EarnsTable extends Earns with TableInfo<$EarnsTable, EarnRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EarnsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<int> productId = GeneratedColumn<int>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES products (id)',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    check: () => ComparableExpr(quantity).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _earnPointsMeta = const VerificationMeta(
    'earnPoints',
  );
  @override
  late final GeneratedColumn<int> earnPoints = GeneratedColumn<int>(
    'earn_points',
    aliasedName,
    false,
    check: () => ComparableExpr(earnPoints).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, productId, quantity, earnPoints];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'earns';
  @override
  VerificationContext validateIntegrity(
    Insertable<EarnRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('earn_points')) {
      context.handle(
        _earnPointsMeta,
        earnPoints.isAcceptableOrUnknown(data['earn_points']!, _earnPointsMeta),
      );
    } else if (isInserting) {
      context.missing(_earnPointsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EarnRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EarnRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}product_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      earnPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}earn_points'],
      )!,
    );
  }

  @override
  $EarnsTable createAlias(String alias) {
    return $EarnsTable(attachedDatabase, alias);
  }
}

class EarnRow extends DataClass implements Insertable<EarnRow> {
  final int id;
  final int productId;
  final int quantity;
  final int earnPoints;
  const EarnRow({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.earnPoints,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<int>(productId);
    map['quantity'] = Variable<int>(quantity);
    map['earn_points'] = Variable<int>(earnPoints);
    return map;
  }

  EarnsCompanion toCompanion(bool nullToAbsent) {
    return EarnsCompanion(
      id: Value(id),
      productId: Value(productId),
      quantity: Value(quantity),
      earnPoints: Value(earnPoints),
    );
  }

  factory EarnRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EarnRow(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      earnPoints: serializer.fromJson<int>(json['earnPoints']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<int>(productId),
      'quantity': serializer.toJson<int>(quantity),
      'earnPoints': serializer.toJson<int>(earnPoints),
    };
  }

  EarnRow copyWith({int? id, int? productId, int? quantity, int? earnPoints}) =>
      EarnRow(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        earnPoints: earnPoints ?? this.earnPoints,
      );
  EarnRow copyWithCompanion(EarnsCompanion data) {
    return EarnRow(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      earnPoints: data.earnPoints.present
          ? data.earnPoints.value
          : this.earnPoints,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EarnRow(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('earnPoints: $earnPoints')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, productId, quantity, earnPoints);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EarnRow &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.quantity == this.quantity &&
          other.earnPoints == this.earnPoints);
}

class EarnsCompanion extends UpdateCompanion<EarnRow> {
  final Value<int> id;
  final Value<int> productId;
  final Value<int> quantity;
  final Value<int> earnPoints;
  const EarnsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.earnPoints = const Value.absent(),
  });
  EarnsCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int quantity,
    required int earnPoints,
  }) : productId = Value(productId),
       quantity = Value(quantity),
       earnPoints = Value(earnPoints);
  static Insertable<EarnRow> custom({
    Expression<int>? id,
    Expression<int>? productId,
    Expression<int>? quantity,
    Expression<int>? earnPoints,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (quantity != null) 'quantity': quantity,
      if (earnPoints != null) 'earn_points': earnPoints,
    });
  }

  EarnsCompanion copyWith({
    Value<int>? id,
    Value<int>? productId,
    Value<int>? quantity,
    Value<int>? earnPoints,
  }) {
    return EarnsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      earnPoints: earnPoints ?? this.earnPoints,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<int>(productId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (earnPoints.present) {
      map['earn_points'] = Variable<int>(earnPoints.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EarnsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('quantity: $quantity, ')
          ..write('earnPoints: $earnPoints')
          ..write(')'))
        .toString();
  }
}

class $GiftsTable extends Gifts with TableInfo<$GiftsTable, GiftRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GiftsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _giftPointsMeta = const VerificationMeta(
    'giftPoints',
  );
  @override
  late final GeneratedColumn<int> giftPoints = GeneratedColumn<int>(
    'gift_points',
    aliasedName,
    false,
    check: () => ComparableExpr(giftPoints).isBiggerThanValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    imageUrl,
    giftPoints,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gifts';
  @override
  VerificationContext validateIntegrity(
    Insertable<GiftRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('gift_points')) {
      context.handle(
        _giftPointsMeta,
        giftPoints.isAcceptableOrUnknown(data['gift_points']!, _giftPointsMeta),
      );
    } else if (isInserting) {
      context.missing(_giftPointsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GiftRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GiftRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
      giftPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gift_points'],
      )!,
    );
  }

  @override
  $GiftsTable createAlias(String alias) {
    return $GiftsTable(attachedDatabase, alias);
  }
}

class GiftRow extends DataClass implements Insertable<GiftRow> {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int giftPoints;
  const GiftRow({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.giftPoints,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['image_url'] = Variable<String>(imageUrl);
    map['gift_points'] = Variable<int>(giftPoints);
    return map;
  }

  GiftsCompanion toCompanion(bool nullToAbsent) {
    return GiftsCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      imageUrl: Value(imageUrl),
      giftPoints: Value(giftPoints),
    );
  }

  factory GiftRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GiftRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      giftPoints: serializer.fromJson<int>(json['giftPoints']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'giftPoints': serializer.toJson<int>(giftPoints),
    };
  }

  GiftRow copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    int? giftPoints,
  }) => GiftRow(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    imageUrl: imageUrl ?? this.imageUrl,
    giftPoints: giftPoints ?? this.giftPoints,
  );
  GiftRow copyWithCompanion(GiftsCompanion data) {
    return GiftRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      giftPoints: data.giftPoints.present
          ? data.giftPoints.value
          : this.giftPoints,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GiftRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('giftPoints: $giftPoints')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, imageUrl, giftPoints);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GiftRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.giftPoints == this.giftPoints);
}

class GiftsCompanion extends UpdateCompanion<GiftRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> description;
  final Value<String> imageUrl;
  final Value<int> giftPoints;
  const GiftsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.giftPoints = const Value.absent(),
  });
  GiftsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String description,
    required String imageUrl,
    required int giftPoints,
  }) : name = Value(name),
       description = Value(description),
       imageUrl = Value(imageUrl),
       giftPoints = Value(giftPoints);
  static Insertable<GiftRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<int>? giftPoints,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (giftPoints != null) 'gift_points': giftPoints,
    });
  }

  GiftsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? description,
    Value<String>? imageUrl,
    Value<int>? giftPoints,
  }) {
    return GiftsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      giftPoints: giftPoints ?? this.giftPoints,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (giftPoints.present) {
      map['gift_points'] = Variable<int>(giftPoints.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GiftsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('giftPoints: $giftPoints')
          ..write(')'))
        .toString();
  }
}

class $EarnProgressTable extends EarnProgress
    with TableInfo<$EarnProgressTable, EarnProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EarnProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES users (id)',
    ),
  );
  static const VerificationMeta _earnIdMeta = const VerificationMeta('earnId');
  @override
  late final GeneratedColumn<int> earnId = GeneratedColumn<int>(
    'earn_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES earns (id)',
    ),
  );
  static const VerificationMeta _completedQuantityMeta = const VerificationMeta(
    'completedQuantity',
  );
  @override
  late final GeneratedColumn<int> completedQuantity = GeneratedColumn<int>(
    'completed_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL CHECK (completed_quantity >= 0)',
  );
  @override
  List<GeneratedColumn> get $columns => [userId, earnId, completedQuantity];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'earn_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<EarnProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('earn_id')) {
      context.handle(
        _earnIdMeta,
        earnId.isAcceptableOrUnknown(data['earn_id']!, _earnIdMeta),
      );
    } else if (isInserting) {
      context.missing(_earnIdMeta);
    }
    if (data.containsKey('completed_quantity')) {
      context.handle(
        _completedQuantityMeta,
        completedQuantity.isAcceptableOrUnknown(
          data['completed_quantity']!,
          _completedQuantityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedQuantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, earnId};
  @override
  EarnProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EarnProgressRow(
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      earnId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}earn_id'],
      )!,
      completedQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_quantity'],
      )!,
    );
  }

  @override
  $EarnProgressTable createAlias(String alias) {
    return $EarnProgressTable(attachedDatabase, alias);
  }
}

class EarnProgressRow extends DataClass implements Insertable<EarnProgressRow> {
  final int userId;
  final int earnId;
  final int completedQuantity;
  const EarnProgressRow({
    required this.userId,
    required this.earnId,
    required this.completedQuantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['earn_id'] = Variable<int>(earnId);
    map['completed_quantity'] = Variable<int>(completedQuantity);
    return map;
  }

  EarnProgressCompanion toCompanion(bool nullToAbsent) {
    return EarnProgressCompanion(
      userId: Value(userId),
      earnId: Value(earnId),
      completedQuantity: Value(completedQuantity),
    );
  }

  factory EarnProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EarnProgressRow(
      userId: serializer.fromJson<int>(json['userId']),
      earnId: serializer.fromJson<int>(json['earnId']),
      completedQuantity: serializer.fromJson<int>(json['completedQuantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<int>(userId),
      'earnId': serializer.toJson<int>(earnId),
      'completedQuantity': serializer.toJson<int>(completedQuantity),
    };
  }

  EarnProgressRow copyWith({
    int? userId,
    int? earnId,
    int? completedQuantity,
  }) => EarnProgressRow(
    userId: userId ?? this.userId,
    earnId: earnId ?? this.earnId,
    completedQuantity: completedQuantity ?? this.completedQuantity,
  );
  EarnProgressRow copyWithCompanion(EarnProgressCompanion data) {
    return EarnProgressRow(
      userId: data.userId.present ? data.userId.value : this.userId,
      earnId: data.earnId.present ? data.earnId.value : this.earnId,
      completedQuantity: data.completedQuantity.present
          ? data.completedQuantity.value
          : this.completedQuantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EarnProgressRow(')
          ..write('userId: $userId, ')
          ..write('earnId: $earnId, ')
          ..write('completedQuantity: $completedQuantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, earnId, completedQuantity);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EarnProgressRow &&
          other.userId == this.userId &&
          other.earnId == this.earnId &&
          other.completedQuantity == this.completedQuantity);
}

class EarnProgressCompanion extends UpdateCompanion<EarnProgressRow> {
  final Value<int> userId;
  final Value<int> earnId;
  final Value<int> completedQuantity;
  final Value<int> rowid;
  const EarnProgressCompanion({
    this.userId = const Value.absent(),
    this.earnId = const Value.absent(),
    this.completedQuantity = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EarnProgressCompanion.insert({
    required int userId,
    required int earnId,
    required int completedQuantity,
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       earnId = Value(earnId),
       completedQuantity = Value(completedQuantity);
  static Insertable<EarnProgressRow> custom({
    Expression<int>? userId,
    Expression<int>? earnId,
    Expression<int>? completedQuantity,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (earnId != null) 'earn_id': earnId,
      if (completedQuantity != null) 'completed_quantity': completedQuantity,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EarnProgressCompanion copyWith({
    Value<int>? userId,
    Value<int>? earnId,
    Value<int>? completedQuantity,
    Value<int>? rowid,
  }) {
    return EarnProgressCompanion(
      userId: userId ?? this.userId,
      earnId: earnId ?? this.earnId,
      completedQuantity: completedQuantity ?? this.completedQuantity,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (earnId.present) {
      map['earn_id'] = Variable<int>(earnId.value);
    }
    if (completedQuantity.present) {
      map['completed_quantity'] = Variable<int>(completedQuantity.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EarnProgressCompanion(')
          ..write('userId: $userId, ')
          ..write('earnId: $earnId, ')
          ..write('completedQuantity: $completedQuantity, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $MembersTable members = $MembersTable(this);
  late final $ProductTypesTable productTypes = $ProductTypesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $BannersTable banners = $BannersTable(this);
  late final $ShopsTable shops = $ShopsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $CategoryProductsTable categoryProducts = $CategoryProductsTable(
    this,
  );
  late final $RewardsTable rewards = $RewardsTable(this);
  late final $EarnsTable earns = $EarnsTable(this);
  late final $GiftsTable gifts = $GiftsTable(this);
  late final $EarnProgressTable earnProgress = $EarnProgressTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    members,
    productTypes,
    products,
    banners,
    shops,
    categories,
    categoryProducts,
    rewards,
    earns,
    gifts,
    earnProgress,
  ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> phone,
  Value<DateTime?> dob,
  Value<int> currentPoints,
  Value<int> memberId,
  Value<bool> isVerified,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> phone,
  Value<DateTime?> dob,
  Value<int> currentPoints,
  Value<int> memberId,
  Value<bool> isVerified,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EarnProgressTable, List<EarnProgressRow>>
  _earnProgressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.earnProgress,
    aliasName: 'users__id__earn_progress__user_id',
  );

  $$EarnProgressTableProcessedTableManager get earnProgressRefs {
    final manager = $$EarnProgressTableTableManager(
      $_db,
      $_db.earnProgress,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_earnProgressRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
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

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentPoints => $composableBuilder(
    column: $table.currentPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> earnProgressRefs(
    Expression<bool> Function($$EarnProgressTableFilterComposer f) f,
  ) {
    final $$EarnProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.earnProgress,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EarnProgressTableFilterComposer(
            $db: $db,
            $table: $db.earnProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
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

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentPoints => $composableBuilder(
    column: $table.currentPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get memberId => $composableBuilder(
    column: $table.memberId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<DateTime> get dob =>
      $composableBuilder(column: $table.dob, builder: (column) => column);

  GeneratedColumn<int> get currentPoints => $composableBuilder(
    column: $table.currentPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get memberId =>
      $composableBuilder(column: $table.memberId, builder: (column) => column);

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> earnProgressRefs<T extends Object>(
    Expression<T> Function($$EarnProgressTableAnnotationComposer a) f,
  ) {
    final $$EarnProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.earnProgress,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EarnProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.earnProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({bool earnProgressRefs})
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<DateTime?> dob = const Value.absent(),
                Value<int> currentPoints = const Value.absent(),
                Value<int> memberId = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                firstName: firstName,
                lastName: lastName,
                phone: phone,
                dob: dob,
                currentPoints: currentPoints,
                memberId: memberId,
                isVerified: isVerified,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<DateTime?> dob = const Value.absent(),
                Value<int> currentPoints = const Value.absent(),
                Value<int> memberId = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => UsersCompanion.insert(
                id: id,
                firstName: firstName,
                lastName: lastName,
                phone: phone,
                dob: dob,
                currentPoints: currentPoints,
                memberId: memberId,
                isVerified: isVerified,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsersTable, User>(table),
                  $$UsersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({earnProgressRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (earnProgressRefs) db.earnProgress],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (earnProgressRefs)
                    await $_getPrefetchedDataByColumns<
                      User,
                      $UsersTable,
                      EarnProgressRow,
                      $EarnProgressTable
                    >(
                      currentTable: table,
                      referencedTable: $$UsersTableReferences
                          ._earnProgressRefsTable(db),
                      managerFromTypedResult: (p0) => $$UsersTableReferences(
                        db,
                        table,
                        p0,
                      ).earnProgressRefs,
                      currentColumn: 'id',
                      referencedColumn: 'user_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({bool earnProgressRefs})
    >;
typedef $$MembersTableCreateCompanionBuilder = MembersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<String> imageUrl,
  Value<int> memberPoints,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$MembersTableUpdateCompanionBuilder = MembersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<String> imageUrl,
  Value<int> memberPoints,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$MembersTableFilterComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get memberPoints => $composableBuilder(
    column: $table.memberPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MembersTableOrderingComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get memberPoints => $composableBuilder(
    column: $table.memberPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MembersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MembersTable> {
  $$MembersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get memberPoints => $composableBuilder(
    column: $table.memberPoints,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MembersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MembersTable,
          Member,
          $$MembersTableFilterComposer,
          $$MembersTableOrderingComposer,
          $$MembersTableAnnotationComposer,
          $$MembersTableCreateCompanionBuilder,
          $$MembersTableUpdateCompanionBuilder,
          (Member, BaseReferences<_$AppDatabase, $MembersTable, Member>),
          Member,
          PrefetchHooks Function()
        > {
  $$MembersTableTableManager(_$AppDatabase db, $MembersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MembersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MembersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MembersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> memberPoints = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MembersCompanion(
                id: id,
                name: name,
                description: description,
                imageUrl: imageUrl,
                memberPoints: memberPoints,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> memberPoints = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => MembersCompanion.insert(
                id: id,
                name: name,
                description: description,
                imageUrl: imageUrl,
                memberPoints: memberPoints,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MembersTable, Member>(table),
                  BaseReferences<_$AppDatabase, $MembersTable, Member>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MembersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MembersTable,
      Member,
      $$MembersTableFilterComposer,
      $$MembersTableOrderingComposer,
      $$MembersTableAnnotationComposer,
      $$MembersTableCreateCompanionBuilder,
      $$MembersTableUpdateCompanionBuilder,
      (Member, BaseReferences<_$AppDatabase, $MembersTable, Member>),
      Member,
      PrefetchHooks Function()
    >;
typedef $$ProductTypesTableCreateCompanionBuilder =
    ProductTypesCompanion Function({
      Value<int> id,
      required String name,
      required String imageUrl,
      required int priorityNo,
    });
typedef $$ProductTypesTableUpdateCompanionBuilder =
    ProductTypesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> imageUrl,
      Value<int> priorityNo,
    });

final class $$ProductTypesTableReferences
    extends BaseReferences<_$AppDatabase, $ProductTypesTable, ProductType> {
  $$ProductTypesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductsTable, List<Product>> _productsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.products,
    aliasName: 'product_types__id__products__product_type_id',
  );

  $$ProductsTableProcessedTableManager get productsRefs {
    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.productTypeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_productsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductTypesTableFilterComposer
    extends Composer<_$AppDatabase, $ProductTypesTable> {
  $$ProductTypesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priorityNo => $composableBuilder(
    column: $table.priorityNo,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productsRefs(
    Expression<bool> Function($$ProductsTableFilterComposer f) f,
  ) {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.productTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductTypesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductTypesTable> {
  $$ProductTypesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priorityNo => $composableBuilder(
    column: $table.priorityNo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductTypesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductTypesTable> {
  $$ProductTypesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get priorityNo => $composableBuilder(
    column: $table.priorityNo,
    builder: (column) => column,
  );

  Expression<T> productsRefs<T extends Object>(
    Expression<T> Function($$ProductsTableAnnotationComposer a) f,
  ) {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.productTypeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductTypesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductTypesTable,
          ProductType,
          $$ProductTypesTableFilterComposer,
          $$ProductTypesTableOrderingComposer,
          $$ProductTypesTableAnnotationComposer,
          $$ProductTypesTableCreateCompanionBuilder,
          $$ProductTypesTableUpdateCompanionBuilder,
          (ProductType, $$ProductTypesTableReferences),
          ProductType,
          PrefetchHooks Function({bool productsRefs})
        > {
  $$ProductTypesTableTableManager(_$AppDatabase db, $ProductTypesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductTypesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductTypesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductTypesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> priorityNo = const Value.absent(),
              }) => ProductTypesCompanion(
                id: id,
                name: name,
                imageUrl: imageUrl,
                priorityNo: priorityNo,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String imageUrl,
                required int priorityNo,
              }) => ProductTypesCompanion.insert(
                id: id,
                name: name,
                imageUrl: imageUrl,
                priorityNo: priorityNo,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductTypesTable, ProductType>(table),
                  $$ProductTypesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productsRefs) db.products],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productsRefs)
                    await $_getPrefetchedDataByColumns<
                      ProductType,
                      $ProductTypesTable,
                      Product,
                      $ProductsTable
                    >(
                      currentTable: table,
                      referencedTable: $$ProductTypesTableReferences
                          ._productsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ProductTypesTableReferences(
                            db,
                            table,
                            p0,
                          ).productsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'product_type_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ProductTypesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductTypesTable,
      ProductType,
      $$ProductTypesTableFilterComposer,
      $$ProductTypesTableOrderingComposer,
      $$ProductTypesTableAnnotationComposer,
      $$ProductTypesTableCreateCompanionBuilder,
      $$ProductTypesTableUpdateCompanionBuilder,
      (ProductType, $$ProductTypesTableReferences),
      ProductType,
      PrefetchHooks Function({bool productsRefs})
    >;
typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  required String name,
  required String imageUrl,
  required int priorityNo,
  Value<double?> price,
  Value<String?> currency,
  Value<String?> productCode,
  Value<String?> description,
  required bool isNew,
  Value<double?> discountPercentage,
  Value<double?> discountAmount,
  required int productTypeId,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> imageUrl,
  Value<int> priorityNo,
  Value<double?> price,
  Value<String?> currency,
  Value<String?> productCode,
  Value<String?> description,
  Value<bool> isNew,
  Value<double?> discountPercentage,
  Value<double?> discountAmount,
  Value<int> productTypeId,
});

final class $$ProductsTableReferences
    extends BaseReferences<_$AppDatabase, $ProductsTable, Product> {
  $$ProductsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductTypesTable _productTypeIdTable(_$AppDatabase db) => db
      .productTypes
      .createAlias('products__product_type_id__product_types__id');

  $$ProductTypesTableProcessedTableManager get productTypeId {
    final $_column = $_itemColumn<int>('product_type_id')!;

    final manager = $$ProductTypesTableTableManager(
      $_db,
      $_db.productTypes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productTypeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CategoryProductsTable, List<CategoryProduct>>
  _categoryProductsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.categoryProducts,
    aliasName: 'products__id__category_products__product_id',
  );

  $$CategoryProductsTableProcessedTableManager get categoryProductsRefs {
    final manager = $$CategoryProductsTableTableManager(
      $_db,
      $_db.categoryProducts,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _categoryProductsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EarnsTable, List<EarnRow>> _earnsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.earns,
    aliasName: 'products__id__earns__product_id',
  );

  $$EarnsTableProcessedTableManager get earnsRefs {
    final manager = $$EarnsTableTableManager(
      $_db,
      $_db.earns,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_earnsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priorityNo => $composableBuilder(
    column: $table.priorityNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductTypesTableFilterComposer get productTypeId {
    final $$ProductTypesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productTypeId,
      referencedTable: $db.productTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTypesTableFilterComposer(
            $db: $db,
            $table: $db.productTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> categoryProductsRefs(
    Expression<bool> Function($$CategoryProductsTableFilterComposer f) f,
  ) {
    final $$CategoryProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoryProducts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryProductsTableFilterComposer(
            $db: $db,
            $table: $db.categoryProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> earnsRefs(
    Expression<bool> Function($$EarnsTableFilterComposer f) f,
  ) {
    final $$EarnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.earns,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EarnsTableFilterComposer(
            $db: $db,
            $table: $db.earns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priorityNo => $composableBuilder(
    column: $table.priorityNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductTypesTableOrderingComposer get productTypeId {
    final $$ProductTypesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productTypeId,
      referencedTable: $db.productTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTypesTableOrderingComposer(
            $db: $db,
            $table: $db.productTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get priorityNo => $composableBuilder(
    column: $table.priorityNo,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get productCode => $composableBuilder(
    column: $table.productCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<double> get discountPercentage => $composableBuilder(
    column: $table.discountPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => column,
  );

  $$ProductTypesTableAnnotationComposer get productTypeId {
    final $$ProductTypesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productTypeId,
      referencedTable: $db.productTypes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductTypesTableAnnotationComposer(
            $db: $db,
            $table: $db.productTypes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> categoryProductsRefs<T extends Object>(
    Expression<T> Function($$CategoryProductsTableAnnotationComposer a) f,
  ) {
    final $$CategoryProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoryProducts,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.categoryProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> earnsRefs<T extends Object>(
    Expression<T> Function($$EarnsTableAnnotationComposer a) f,
  ) {
    final $$EarnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.earns,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EarnsTableAnnotationComposer(
            $db: $db,
            $table: $db.earns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, $$ProductsTableReferences),
          Product,
          PrefetchHooks Function({
            bool productTypeId,
            bool categoryProductsRefs,
            bool earnsRefs,
          })
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> priorityNo = const Value.absent(),
                Value<double?> price = const Value.absent(),
                Value<String?> currency = const Value.absent(),
                Value<String?> productCode = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isNew = const Value.absent(),
                Value<double?> discountPercentage = const Value.absent(),
                Value<double?> discountAmount = const Value.absent(),
                Value<int> productTypeId = const Value.absent(),
              }) => ProductsCompanion(
                id: id,
                name: name,
                imageUrl: imageUrl,
                priorityNo: priorityNo,
                price: price,
                currency: currency,
                productCode: productCode,
                description: description,
                isNew: isNew,
                discountPercentage: discountPercentage,
                discountAmount: discountAmount,
                productTypeId: productTypeId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String imageUrl,
                required int priorityNo,
                Value<double?> price = const Value.absent(),
                Value<String?> currency = const Value.absent(),
                Value<String?> productCode = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required bool isNew,
                Value<double?> discountPercentage = const Value.absent(),
                Value<double?> discountAmount = const Value.absent(),
                required int productTypeId,
              }) => ProductsCompanion.insert(
                id: id,
                name: name,
                imageUrl: imageUrl,
                priorityNo: priorityNo,
                price: price,
                currency: currency,
                productCode: productCode,
                description: description,
                isNew: isNew,
                discountPercentage: discountPercentage,
                discountAmount: discountAmount,
                productTypeId: productTypeId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductsTable, Product>(table),
                  $$ProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                productTypeId = false,
                categoryProductsRefs = false,
                earnsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (categoryProductsRefs) db.categoryProducts,
                    if (earnsRefs) db.earns,
                  ],
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
                        if (productTypeId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.productTypeId,
                            referencedTable: $$ProductsTableReferences
                                ._productTypeIdTable(db),
                            referencedColumn: $$ProductsTableReferences
                                ._productTypeIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (categoryProductsRefs)
                        await $_getPrefetchedDataByColumns<
                          Product,
                          $ProductsTable,
                          CategoryProduct,
                          $CategoryProductsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._categoryProductsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).categoryProductsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'product_id',
                          typedResults: items,
                        ),
                      if (earnsRefs)
                        await $_getPrefetchedDataByColumns<
                          Product,
                          $ProductsTable,
                          EarnRow,
                          $EarnsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProductsTableReferences
                              ._earnsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductsTableReferences(
                                db,
                                table,
                                p0,
                              ).earnsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'product_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, $$ProductsTableReferences),
      Product,
      PrefetchHooks Function({
        bool productTypeId,
        bool categoryProductsRefs,
        bool earnsRefs,
      })
    >;
typedef $$BannersTableCreateCompanionBuilder = BannersCompanion Function({
  Value<int> id,
  required String name,
  required String imageUrl,
});
typedef $$BannersTableUpdateCompanionBuilder = BannersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> imageUrl,
});

class $$BannersTableFilterComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BannersTableOrderingComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BannersTableAnnotationComposer
    extends Composer<_$AppDatabase, $BannersTable> {
  $$BannersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);
}

class $$BannersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BannersTable,
          Banner,
          $$BannersTableFilterComposer,
          $$BannersTableOrderingComposer,
          $$BannersTableAnnotationComposer,
          $$BannersTableCreateCompanionBuilder,
          $$BannersTableUpdateCompanionBuilder,
          (Banner, BaseReferences<_$AppDatabase, $BannersTable, Banner>),
          Banner,
          PrefetchHooks Function()
        > {
  $$BannersTableTableManager(_$AppDatabase db, $BannersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BannersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BannersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BannersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> imageUrl = const Value.absent(),
          }) => BannersCompanion(id: id, name: name, imageUrl: imageUrl),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String imageUrl,
          }) => BannersCompanion.insert(id: id, name: name, imageUrl: imageUrl),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BannersTable, Banner>(table),
                  BaseReferences<_$AppDatabase, $BannersTable, Banner>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BannersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BannersTable,
      Banner,
      $$BannersTableFilterComposer,
      $$BannersTableOrderingComposer,
      $$BannersTableAnnotationComposer,
      $$BannersTableCreateCompanionBuilder,
      $$BannersTableUpdateCompanionBuilder,
      (Banner, BaseReferences<_$AppDatabase, $BannersTable, Banner>),
      Banner,
      PrefetchHooks Function()
    >;
typedef $$ShopsTableCreateCompanionBuilder = ShopsCompanion Function({
  Value<int> id,
  required String name,
  required String description,
  required String address,
  required String imageUrl,
  required double lat,
  required double lng,
});
typedef $$ShopsTableUpdateCompanionBuilder = ShopsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<String> address,
  Value<String> imageUrl,
  Value<double> lat,
  Value<double> lng,
});

class $$ShopsTableFilterComposer extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopsTable> {
  $$ShopsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);
}

class $$ShopsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopsTable,
          Shop,
          $$ShopsTableFilterComposer,
          $$ShopsTableOrderingComposer,
          $$ShopsTableAnnotationComposer,
          $$ShopsTableCreateCompanionBuilder,
          $$ShopsTableUpdateCompanionBuilder,
          (Shop, BaseReferences<_$AppDatabase, $ShopsTable, Shop>),
          Shop,
          PrefetchHooks Function()
        > {
  $$ShopsTableTableManager(_$AppDatabase db, $ShopsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lng = const Value.absent(),
              }) => ShopsCompanion(
                id: id,
                name: name,
                description: description,
                address: address,
                imageUrl: imageUrl,
                lat: lat,
                lng: lng,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                required String address,
                required String imageUrl,
                required double lat,
                required double lng,
              }) => ShopsCompanion.insert(
                id: id,
                name: name,
                description: description,
                address: address,
                imageUrl: imageUrl,
                lat: lat,
                lng: lng,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShopsTable, Shop>(table),
                  BaseReferences<_$AppDatabase, $ShopsTable, Shop>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopsTable,
      Shop,
      $$ShopsTableFilterComposer,
      $$ShopsTableOrderingComposer,
      $$ShopsTableAnnotationComposer,
      $$ShopsTableCreateCompanionBuilder,
      $$ShopsTableUpdateCompanionBuilder,
      (Shop, BaseReferences<_$AppDatabase, $ShopsTable, Shop>),
      Shop,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  required String name,
  required String imageUrl,
  required int priorityNo,
  required bool isActive,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> imageUrl,
  Value<int> priorityNo,
  Value<bool> isActive,
});

final class $$CategoriesTableReferences
    extends BaseReferences<_$AppDatabase, $CategoriesTable, Category> {
  $$CategoriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CategoryProductsTable, List<CategoryProduct>>
  _categoryProductsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.categoryProducts,
    aliasName: 'categories__id__category_products__category_id',
  );

  $$CategoryProductsTableProcessedTableManager get categoryProductsRefs {
    final manager = $$CategoryProductsTableTableManager(
      $_db,
      $_db.categoryProducts,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _categoryProductsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priorityNo => $composableBuilder(
    column: $table.priorityNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> categoryProductsRefs(
    Expression<bool> Function($$CategoryProductsTableFilterComposer f) f,
  ) {
    final $$CategoryProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoryProducts,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryProductsTableFilterComposer(
            $db: $db,
            $table: $db.categoryProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priorityNo => $composableBuilder(
    column: $table.priorityNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get priorityNo => $composableBuilder(
    column: $table.priorityNo,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> categoryProductsRefs<T extends Object>(
    Expression<T> Function($$CategoryProductsTableAnnotationComposer a) f,
  ) {
    final $$CategoryProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.categoryProducts,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.categoryProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, $$CategoriesTableReferences),
          Category,
          PrefetchHooks Function({bool categoryProductsRefs})
        > {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> priorityNo = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => CategoriesCompanion(
                id: id,
                name: name,
                imageUrl: imageUrl,
                priorityNo: priorityNo,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String imageUrl,
                required int priorityNo,
                required bool isActive,
              }) => CategoriesCompanion.insert(
                id: id,
                name: name,
                imageUrl: imageUrl,
                priorityNo: priorityNo,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriesTable, Category>(table),
                  $$CategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryProductsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (categoryProductsRefs) db.categoryProducts,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (categoryProductsRefs)
                    await $_getPrefetchedDataByColumns<
                      Category,
                      $CategoriesTable,
                      CategoryProduct,
                      $CategoryProductsTable
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriesTableReferences
                          ._categoryProductsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).categoryProductsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'category_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, $$CategoriesTableReferences),
      Category,
      PrefetchHooks Function({bool categoryProductsRefs})
    >;
typedef $$CategoryProductsTableCreateCompanionBuilder =
    CategoryProductsCompanion Function({
      Value<int> id,
      required int categoryId,
      required int productId,
    });
typedef $$CategoryProductsTableUpdateCompanionBuilder =
    CategoryProductsCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<int> productId,
    });

final class $$CategoryProductsTableReferences
    extends
        BaseReferences<_$AppDatabase, $CategoryProductsTable, CategoryProduct> {
  $$CategoryProductsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoriesTable _categoryIdTable(_$AppDatabase db) => db.categories
      .createAlias('category_products__category_id__categories__id');

  $$CategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoriesTableTableManager(
      $_db,
      $_db.categories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('category_products__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CategoryProductsTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryProductsTable> {
  $$CategoryProductsTableFilterComposer({
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

  $$CategoriesTableFilterComposer get categoryId {
    final $$CategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableFilterComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoryProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryProductsTable> {
  $$CategoryProductsTableOrderingComposer({
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

  $$CategoriesTableOrderingComposer get categoryId {
    final $$CategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoryProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryProductsTable> {
  $$CategoryProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$CategoriesTableAnnotationComposer get categoryId {
    final $$CategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.categories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoryProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryProductsTable,
          CategoryProduct,
          $$CategoryProductsTableFilterComposer,
          $$CategoryProductsTableOrderingComposer,
          $$CategoryProductsTableAnnotationComposer,
          $$CategoryProductsTableCreateCompanionBuilder,
          $$CategoryProductsTableUpdateCompanionBuilder,
          (CategoryProduct, $$CategoryProductsTableReferences),
          CategoryProduct,
          PrefetchHooks Function({bool categoryId, bool productId})
        > {
  $$CategoryProductsTableTableManager(
    _$AppDatabase db,
    $CategoryProductsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<int> productId = const Value.absent(),
              }) => CategoryProductsCompanion(
                id: id,
                categoryId: categoryId,
                productId: productId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required int productId,
              }) => CategoryProductsCompanion.insert(
                id: id,
                categoryId: categoryId,
                productId: productId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoryProductsTable, CategoryProduct>(table),
                  $$CategoryProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({categoryId = false, productId = false}) {
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
                    if (categoryId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.categoryId,
                        referencedTable: $$CategoryProductsTableReferences
                            ._categoryIdTable(db),
                        referencedColumn: $$CategoryProductsTableReferences
                            ._categoryIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (productId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productId,
                        referencedTable: $$CategoryProductsTableReferences
                            ._productIdTable(db),
                        referencedColumn: $$CategoryProductsTableReferences
                            ._productIdTable(db)
                            .id,
                      ) as T;
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

typedef $$CategoryProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryProductsTable,
      CategoryProduct,
      $$CategoryProductsTableFilterComposer,
      $$CategoryProductsTableOrderingComposer,
      $$CategoryProductsTableAnnotationComposer,
      $$CategoryProductsTableCreateCompanionBuilder,
      $$CategoryProductsTableUpdateCompanionBuilder,
      (CategoryProduct, $$CategoryProductsTableReferences),
      CategoryProduct,
      PrefetchHooks Function({bool categoryId, bool productId})
    >;
typedef $$RewardsTableCreateCompanionBuilder = RewardsCompanion Function({
  Value<int> id,
  required String name,
  required String description,
  required String imageUrl,
  required String colorCode,
  required int rewardPoints,
});
typedef $$RewardsTableUpdateCompanionBuilder = RewardsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<String> imageUrl,
  Value<String> colorCode,
  Value<int> rewardPoints,
});

class $$RewardsTableFilterComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorCode => $composableBuilder(
    column: $table.colorCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RewardsTableOrderingComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorCode => $composableBuilder(
    column: $table.colorCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RewardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RewardsTable> {
  $$RewardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get colorCode =>
      $composableBuilder(column: $table.colorCode, builder: (column) => column);

  GeneratedColumn<int> get rewardPoints => $composableBuilder(
    column: $table.rewardPoints,
    builder: (column) => column,
  );
}

class $$RewardsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RewardsTable,
          RewardRow,
          $$RewardsTableFilterComposer,
          $$RewardsTableOrderingComposer,
          $$RewardsTableAnnotationComposer,
          $$RewardsTableCreateCompanionBuilder,
          $$RewardsTableUpdateCompanionBuilder,
          (RewardRow, BaseReferences<_$AppDatabase, $RewardsTable, RewardRow>),
          RewardRow,
          PrefetchHooks Function()
        > {
  $$RewardsTableTableManager(_$AppDatabase db, $RewardsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RewardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RewardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RewardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> colorCode = const Value.absent(),
                Value<int> rewardPoints = const Value.absent(),
              }) => RewardsCompanion(
                id: id,
                name: name,
                description: description,
                imageUrl: imageUrl,
                colorCode: colorCode,
                rewardPoints: rewardPoints,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                required String imageUrl,
                required String colorCode,
                required int rewardPoints,
              }) => RewardsCompanion.insert(
                id: id,
                name: name,
                description: description,
                imageUrl: imageUrl,
                colorCode: colorCode,
                rewardPoints: rewardPoints,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RewardsTable, RewardRow>(table),
                  BaseReferences<_$AppDatabase, $RewardsTable, RewardRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RewardsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RewardsTable,
      RewardRow,
      $$RewardsTableFilterComposer,
      $$RewardsTableOrderingComposer,
      $$RewardsTableAnnotationComposer,
      $$RewardsTableCreateCompanionBuilder,
      $$RewardsTableUpdateCompanionBuilder,
      (RewardRow, BaseReferences<_$AppDatabase, $RewardsTable, RewardRow>),
      RewardRow,
      PrefetchHooks Function()
    >;
typedef $$EarnsTableCreateCompanionBuilder = EarnsCompanion Function({
  Value<int> id,
  required int productId,
  required int quantity,
  required int earnPoints,
});
typedef $$EarnsTableUpdateCompanionBuilder = EarnsCompanion Function({
  Value<int> id,
  Value<int> productId,
  Value<int> quantity,
  Value<int> earnPoints,
});

final class $$EarnsTableReferences
    extends BaseReferences<_$AppDatabase, $EarnsTable, EarnRow> {
  $$EarnsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProductsTable _productIdTable(_$AppDatabase db) =>
      db.products.createAlias('earns__product_id__products__id');

  $$ProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<int>('product_id')!;

    final manager = $$ProductsTableTableManager(
      $_db,
      $_db.products,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EarnProgressTable, List<EarnProgressRow>>
  _earnProgressRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.earnProgress,
    aliasName: 'earns__id__earn_progress__earn_id',
  );

  $$EarnProgressTableProcessedTableManager get earnProgressRefs {
    final manager = $$EarnProgressTableTableManager(
      $_db,
      $_db.earnProgress,
    ).filter((f) => f.earnId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_earnProgressRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EarnsTableFilterComposer extends Composer<_$AppDatabase, $EarnsTable> {
  $$EarnsTableFilterComposer({
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

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get earnPoints => $composableBuilder(
    column: $table.earnPoints,
    builder: (column) => ColumnFilters(column),
  );

  $$ProductsTableFilterComposer get productId {
    final $$ProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableFilterComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> earnProgressRefs(
    Expression<bool> Function($$EarnProgressTableFilterComposer f) f,
  ) {
    final $$EarnProgressTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.earnProgress,
      getReferencedColumn: (t) => t.earnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EarnProgressTableFilterComposer(
            $db: $db,
            $table: $db.earnProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EarnsTableOrderingComposer
    extends Composer<_$AppDatabase, $EarnsTable> {
  $$EarnsTableOrderingComposer({
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

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get earnPoints => $composableBuilder(
    column: $table.earnPoints,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProductsTableOrderingComposer get productId {
    final $$ProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableOrderingComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EarnsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EarnsTable> {
  $$EarnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get earnPoints => $composableBuilder(
    column: $table.earnPoints,
    builder: (column) => column,
  );

  $$ProductsTableAnnotationComposer get productId {
    final $$ProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.products,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.products,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> earnProgressRefs<T extends Object>(
    Expression<T> Function($$EarnProgressTableAnnotationComposer a) f,
  ) {
    final $$EarnProgressTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.earnProgress,
      getReferencedColumn: (t) => t.earnId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EarnProgressTableAnnotationComposer(
            $db: $db,
            $table: $db.earnProgress,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EarnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EarnsTable,
          EarnRow,
          $$EarnsTableFilterComposer,
          $$EarnsTableOrderingComposer,
          $$EarnsTableAnnotationComposer,
          $$EarnsTableCreateCompanionBuilder,
          $$EarnsTableUpdateCompanionBuilder,
          (EarnRow, $$EarnsTableReferences),
          EarnRow,
          PrefetchHooks Function({bool productId, bool earnProgressRefs})
        > {
  $$EarnsTableTableManager(_$AppDatabase db, $EarnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EarnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EarnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EarnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> productId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> earnPoints = const Value.absent(),
              }) => EarnsCompanion(
                id: id,
                productId: productId,
                quantity: quantity,
                earnPoints: earnPoints,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int productId,
                required int quantity,
                required int earnPoints,
              }) => EarnsCompanion.insert(
                id: id,
                productId: productId,
                quantity: quantity,
                earnPoints: earnPoints,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EarnsTable, EarnRow>(table),
                  $$EarnsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({productId = false, earnProgressRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (earnProgressRefs) db.earnProgress,
                  ],
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
                        if (productId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.productId,
                            referencedTable: $$EarnsTableReferences
                                ._productIdTable(db),
                            referencedColumn: $$EarnsTableReferences
                                ._productIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (earnProgressRefs)
                        await $_getPrefetchedDataByColumns<
                          EarnRow,
                          $EarnsTable,
                          EarnProgressRow,
                          $EarnProgressTable
                        >(
                          currentTable: table,
                          referencedTable: $$EarnsTableReferences
                              ._earnProgressRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EarnsTableReferences(
                                db,
                                table,
                                p0,
                              ).earnProgressRefs,
                          currentColumn: 'id',
                          referencedColumn: 'earn_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EarnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EarnsTable,
      EarnRow,
      $$EarnsTableFilterComposer,
      $$EarnsTableOrderingComposer,
      $$EarnsTableAnnotationComposer,
      $$EarnsTableCreateCompanionBuilder,
      $$EarnsTableUpdateCompanionBuilder,
      (EarnRow, $$EarnsTableReferences),
      EarnRow,
      PrefetchHooks Function({bool productId, bool earnProgressRefs})
    >;
typedef $$GiftsTableCreateCompanionBuilder = GiftsCompanion Function({
  Value<int> id,
  required String name,
  required String description,
  required String imageUrl,
  required int giftPoints,
});
typedef $$GiftsTableUpdateCompanionBuilder = GiftsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> description,
  Value<String> imageUrl,
  Value<int> giftPoints,
});

class $$GiftsTableFilterComposer extends Composer<_$AppDatabase, $GiftsTable> {
  $$GiftsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get giftPoints => $composableBuilder(
    column: $table.giftPoints,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GiftsTableOrderingComposer
    extends Composer<_$AppDatabase, $GiftsTable> {
  $$GiftsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get giftPoints => $composableBuilder(
    column: $table.giftPoints,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GiftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GiftsTable> {
  $$GiftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get giftPoints => $composableBuilder(
    column: $table.giftPoints,
    builder: (column) => column,
  );
}

class $$GiftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GiftsTable,
          GiftRow,
          $$GiftsTableFilterComposer,
          $$GiftsTableOrderingComposer,
          $$GiftsTableAnnotationComposer,
          $$GiftsTableCreateCompanionBuilder,
          $$GiftsTableUpdateCompanionBuilder,
          (GiftRow, BaseReferences<_$AppDatabase, $GiftsTable, GiftRow>),
          GiftRow,
          PrefetchHooks Function()
        > {
  $$GiftsTableTableManager(_$AppDatabase db, $GiftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GiftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GiftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GiftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> giftPoints = const Value.absent(),
              }) => GiftsCompanion(
                id: id,
                name: name,
                description: description,
                imageUrl: imageUrl,
                giftPoints: giftPoints,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String description,
                required String imageUrl,
                required int giftPoints,
              }) => GiftsCompanion.insert(
                id: id,
                name: name,
                description: description,
                imageUrl: imageUrl,
                giftPoints: giftPoints,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GiftsTable, GiftRow>(table),
                  BaseReferences<_$AppDatabase, $GiftsTable, GiftRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GiftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GiftsTable,
      GiftRow,
      $$GiftsTableFilterComposer,
      $$GiftsTableOrderingComposer,
      $$GiftsTableAnnotationComposer,
      $$GiftsTableCreateCompanionBuilder,
      $$GiftsTableUpdateCompanionBuilder,
      (GiftRow, BaseReferences<_$AppDatabase, $GiftsTable, GiftRow>),
      GiftRow,
      PrefetchHooks Function()
    >;
typedef $$EarnProgressTableCreateCompanionBuilder =
    EarnProgressCompanion Function({
      required int userId,
      required int earnId,
      required int completedQuantity,
      Value<int> rowid,
    });
typedef $$EarnProgressTableUpdateCompanionBuilder =
    EarnProgressCompanion Function({
      Value<int> userId,
      Value<int> earnId,
      Value<int> completedQuantity,
      Value<int> rowid,
    });

final class $$EarnProgressTableReferences
    extends BaseReferences<_$AppDatabase, $EarnProgressTable, EarnProgressRow> {
  $$EarnProgressTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias('earn_progress__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager(
      $_db,
      $_db.users,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EarnsTable _earnIdTable(_$AppDatabase db) =>
      db.earns.createAlias('earn_progress__earn_id__earns__id');

  $$EarnsTableProcessedTableManager get earnId {
    final $_column = $_itemColumn<int>('earn_id')!;

    final manager = $$EarnsTableTableManager(
      $_db,
      $_db.earns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_earnIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EarnProgressTableFilterComposer
    extends Composer<_$AppDatabase, $EarnProgressTable> {
  $$EarnProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get completedQuantity => $composableBuilder(
    column: $table.completedQuantity,
    builder: (column) => ColumnFilters(column),
  );

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EarnsTableFilterComposer get earnId {
    final $$EarnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.earnId,
      referencedTable: $db.earns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EarnsTableFilterComposer(
            $db: $db,
            $table: $db.earns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EarnProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $EarnProgressTable> {
  $$EarnProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get completedQuantity => $composableBuilder(
    column: $table.completedQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EarnsTableOrderingComposer get earnId {
    final $$EarnsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.earnId,
      referencedTable: $db.earns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EarnsTableOrderingComposer(
            $db: $db,
            $table: $db.earns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EarnProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $EarnProgressTable> {
  $$EarnProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get completedQuantity => $composableBuilder(
    column: $table.completedQuantity,
    builder: (column) => column,
  );

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EarnsTableAnnotationComposer get earnId {
    final $$EarnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.earnId,
      referencedTable: $db.earns,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EarnsTableAnnotationComposer(
            $db: $db,
            $table: $db.earns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EarnProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EarnProgressTable,
          EarnProgressRow,
          $$EarnProgressTableFilterComposer,
          $$EarnProgressTableOrderingComposer,
          $$EarnProgressTableAnnotationComposer,
          $$EarnProgressTableCreateCompanionBuilder,
          $$EarnProgressTableUpdateCompanionBuilder,
          (EarnProgressRow, $$EarnProgressTableReferences),
          EarnProgressRow,
          PrefetchHooks Function({bool userId, bool earnId})
        > {
  $$EarnProgressTableTableManager(_$AppDatabase db, $EarnProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EarnProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EarnProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EarnProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> userId = const Value.absent(),
                Value<int> earnId = const Value.absent(),
                Value<int> completedQuantity = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EarnProgressCompanion(
                userId: userId,
                earnId: earnId,
                completedQuantity: completedQuantity,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int userId,
                required int earnId,
                required int completedQuantity,
                Value<int> rowid = const Value.absent(),
              }) => EarnProgressCompanion.insert(
                userId: userId,
                earnId: earnId,
                completedQuantity: completedQuantity,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EarnProgressTable, EarnProgressRow>(table),
                  $$EarnProgressTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false, earnId = false}) {
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
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$EarnProgressTableReferences
                            ._userIdTable(db),
                        referencedColumn: $$EarnProgressTableReferences
                            ._userIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (earnId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.earnId,
                        referencedTable: $$EarnProgressTableReferences
                            ._earnIdTable(db),
                        referencedColumn: $$EarnProgressTableReferences
                            ._earnIdTable(db)
                            .id,
                      ) as T;
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

typedef $$EarnProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EarnProgressTable,
      EarnProgressRow,
      $$EarnProgressTableFilterComposer,
      $$EarnProgressTableOrderingComposer,
      $$EarnProgressTableAnnotationComposer,
      $$EarnProgressTableCreateCompanionBuilder,
      $$EarnProgressTableUpdateCompanionBuilder,
      (EarnProgressRow, $$EarnProgressTableReferences),
      EarnProgressRow,
      PrefetchHooks Function({bool userId, bool earnId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$MembersTableTableManager get members =>
      $$MembersTableTableManager(_db, _db.members);
  $$ProductTypesTableTableManager get productTypes =>
      $$ProductTypesTableTableManager(_db, _db.productTypes);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$BannersTableTableManager get banners =>
      $$BannersTableTableManager(_db, _db.banners);
  $$ShopsTableTableManager get shops =>
      $$ShopsTableTableManager(_db, _db.shops);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
  $$CategoryProductsTableTableManager get categoryProducts =>
      $$CategoryProductsTableTableManager(_db, _db.categoryProducts);
  $$RewardsTableTableManager get rewards =>
      $$RewardsTableTableManager(_db, _db.rewards);
  $$EarnsTableTableManager get earns =>
      $$EarnsTableTableManager(_db, _db.earns);
  $$GiftsTableTableManager get gifts =>
      $$GiftsTableTableManager(_db, _db.gifts);
  $$EarnProgressTableTableManager get earnProgress =>
      $$EarnProgressTableTableManager(_db, _db.earnProgress);
}
