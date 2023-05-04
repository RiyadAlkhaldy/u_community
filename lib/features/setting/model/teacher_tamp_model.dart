// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class TeachersResponse {
  TeachersResponse({
    required this.status,
    required this.teacher,
  });
  final String status;
  final List<Teacher> teacher;

  TeachersResponse copyWith({
    String? status,
    List<Teacher>? teacher,
  }) {
    return TeachersResponse(
      status: status ?? this.status,
      teacher: teacher ?? this.teacher,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'teacher': teacher.map((x) => x.toMap()).toList(),
    };
  }

  factory TeachersResponse.fromMap(Map<String, dynamic> map) {
    return TeachersResponse(
      status: map['status'] as String,
      teacher: List<Teacher>.from(
        (map['teacher']).map<Teacher>(
          (x) => Teacher.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TeachersResponse.fromJson(String source) =>
      TeachersResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TeachersResponse(status: $status, teacher: $teacher)';

  @override
  bool operator ==(covariant TeachersResponse other) {
    if (identical(this, other)) return true;

    return other.status == status && listEquals(other.teacher, teacher);
  }

  @override
  int get hashCode => status.hashCode ^ teacher.hashCode;
}

class Teacher {
  Teacher({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    // this.img,
    // required this.status,
    this.universityId,
    required this.idNumber,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.sectionId,
    required this.collogeId,
    this.level,
    this.type,
  });

  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  // final String? img;
  // final int status;
  final int? universityId;
  final int idNumber;
  final String? description;
  final String createdAt;
  final String updatedAt;
  final int? sectionId;
  final int collogeId;
  final int? level;
  final int? type;

  Teacher copyWith({
    int? id,
    String? name,
    String? email,
    String? emailVerifiedAt,
    // String? img,
    // int? status,
    int? universityId,
    int? idNumber,
    String? description,
    String? createdAt,
    String? updatedAt,
    int? sectionId,
    int? collogeId,
    int? level,
    int? type,
  }) {
    return Teacher(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      // img: img ?? this.img,
      // status: status ?? this.status,
      universityId: universityId ?? this.universityId,
      idNumber: idNumber ?? this.idNumber,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sectionId: sectionId ?? this.sectionId,
      collogeId: collogeId ?? this.collogeId,
      level: level ?? this.level,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'emailVerified_at': emailVerifiedAt,
      // 'img': img,
      // 'status': status,
      'university_id': universityId,
      'id_number': idNumber,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'section_id': sectionId,
      'colloge_id': collogeId,
      'level': level,
      'type': type,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map['id'],
      name: map['name'] as String,
      email: map['email'] as String,
      emailVerifiedAt: map['emailVerified_at'] ?? '',
      // img: map['img'] ?? '',
      // status: map['status'],
      universityId: map['university_id'],
      idNumber: map['id_number'],
      description: map['description'] ?? '',
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
      sectionId: map['section_id'],
      collogeId: map['colloge_id'],
      level: map['level'] ?? 0,
      type: map['type'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Teacher.fromJson(String source) =>
      Teacher.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, img: img, status: status, universityId: $universityId, idNumber: $idNumber, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, sectionId: $sectionId, collogeId: $collogeId, level: $level, type: $type)';
  }

  @override
  bool operator ==(covariant Teacher other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.emailVerifiedAt == emailVerifiedAt &&
        // other.img == img &&
        // other.status == status &&
        other.universityId == universityId &&
        other.idNumber == idNumber &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.sectionId == sectionId &&
        other.collogeId == collogeId &&
        other.level == level &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        emailVerifiedAt.hashCode ^
        // img.hashCode ^
        // status.hashCode ^
        universityId.hashCode ^
        idNumber.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        sectionId.hashCode ^
        collogeId.hashCode ^
        level.hashCode ^
        type.hashCode;
  }
}
