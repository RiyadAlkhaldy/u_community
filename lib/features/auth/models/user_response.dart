import 'dart:convert';

import '../../posts/models/post_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserResponseLogin {
  UserResponseLogin({
    required this.status,
    required this.message,
    this.user,
    required this.authorisation,
  });
  final String status;
  final String message;
  final User? user;
  final Authorisation authorisation;

  UserResponseLogin copyWith({
    String? status,
    String? message,
    User? user,
    Authorisation? authorisation,
  }) {
    return UserResponseLogin(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      authorisation: authorisation ?? this.authorisation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'user': user!.toMap(),
      'authorisation': authorisation.toMap(),
    };
  }

  factory UserResponseLogin.fromMap(Map<String, dynamic> map) {
    return UserResponseLogin(
      status: map['status'] as String,
      message: map['message'] as String,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      authorisation:
          Authorisation.fromMap(map['authorisation'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseLogin.fromJson(String source) =>
      UserResponseLogin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserResponseLogin(status: $status, message: $message, user: $user, authorisation: $authorisation)';
  }

  @override
  bool operator ==(covariant UserResponseLogin other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        other.user == user &&
        other.authorisation == authorisation;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        user.hashCode ^
        authorisation.hashCode;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.img,
    this.status,
    this.universityId,
    this.idNumber,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.sectionId,
    required this.collogeId,
    this.level,
    this.type,
    this.colloge,
    this.section,
  });

  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? img;
  final int? status;
  final int? universityId;
  int? idNumber;
  final String? description;
  final String createdAt;
  final String updatedAt;
  final int? sectionId;
  final int collogeId;
  final int? level;
  final int? type;
  final Colloge? colloge;
  final Section? section;
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? emailVerifiedAt,
    String? img,
    int? status,
    int? universityId,
    int? idNumber,
    String? description,
    String? createdAt,
    String? updatedAt,
    int? sectionId,
    int? collogeId,
    int? level,
    int? type,
    Colloge? colloge,
    Section? section,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      img: img ?? this.img,
      status: status ?? this.status,
      universityId: universityId ?? this.universityId,
      idNumber: idNumber ?? this.idNumber,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sectionId: sectionId ?? this.sectionId,
      collogeId: collogeId ?? this.collogeId,
      level: level ?? this.level,
      type: type ?? this.type,
      colloge: colloge ?? this.colloge,
      section: section ?? this.section,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'emailVerified_at': emailVerifiedAt,
      'img': img,
      'status': status,
      'university_id': universityId,
      'id_number': idNumber,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'section_id': sectionId,
      'colloge_id': collogeId,
      'level': level,
      'type': type,
      'colloge': colloge,
      'section': section,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'] as String,
      email: map['email'] as String,
      emailVerifiedAt: map['emailVerified_at'],
      img: map['img'],
      status: map['status'],
      universityId: map['university_id'],
      idNumber: map['id_number'],
      description: map['description'],
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      sectionId: map['section_id'],
      collogeId: map['colloge_id'],
      level: map['level'],
      type: map['type'],
      colloge: Colloge.fromMap(map['colloge'] as Map<String, dynamic>),
      section: map['section'] == null
          ? null
          : Section.fromMap(map['section'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, img: $img, status: $status, universityId: $universityId, idNumber: $idNumber, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, sectionId: $sectionId, collogeId: $collogeId, level: $level, type: $type)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.emailVerifiedAt == emailVerifiedAt &&
        other.img == img &&
        other.status == status &&
        other.universityId == universityId &&
        other.idNumber == idNumber &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.sectionId == sectionId &&
        other.collogeId == collogeId &&
        other.level == level &&
        other.type == type &&
        other.colloge == colloge &&
        other.section == section;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        emailVerifiedAt.hashCode ^
        img.hashCode ^
        status.hashCode ^
        universityId.hashCode ^
        idNumber.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        sectionId.hashCode ^
        collogeId.hashCode ^
        level.hashCode ^
        type.hashCode ^
        colloge.hashCode ^
        section.hashCode;
  }

  initi() {}
}

class Authorisation {
  Authorisation({
    this.token,
    required this.type,
  });
  final String? token;
  final String type;

  Authorisation copyWith({
    String? token,
    String? type,
  }) {
    return Authorisation(
      token: token ?? this.token,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'type': type,
    };
  }

  factory Authorisation.fromMap(Map<String, dynamic> map) {
    return Authorisation(
      token: map['token'] != null ? map['token'] : null,
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Authorisation.fromJson(String source) =>
      Authorisation.fromMap(json.decode(source));

  @override
  String toString() => 'Authorisation(token: $token, type: $type)';

  @override
  bool operator ==(covariant Authorisation other) {
    if (identical(this, other)) return true;

    return other.token == token && other.type == type;
  }

  @override
  int get hashCode => token.hashCode ^ type.hashCode;
}
