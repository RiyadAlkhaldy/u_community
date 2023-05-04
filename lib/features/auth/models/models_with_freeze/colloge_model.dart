// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'colloge_model.freezed.dart';
// part 'colloge_model.g.dart';

// @freezed
// class CollogeModel with _$CollogeModel {
//   factory CollogeModel({
//     required int id,
//     required String name,
//   }) = _CollogeModel;
//   factory CollogeModel.fromJson(Map<String, dynamic> json) =>
//       _$CollogeModelFromJson(json);
// }

class ResponseColloge {
  final String status;
  final String message;
  final List<Colloge>? colloge;
  ResponseColloge({
    required this.status,
    required this.message,
    required this.colloge,
  });

  ResponseColloge copyWith({
    String? status,
    String? message,
    List<Colloge>? colloges,
  }) {
    return ResponseColloge(
      status: status ?? this.status,
      message: message ?? this.message,
      colloge: colloges ?? this.colloge,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'colloge': colloge!.map((x) => x.toMap()).toList(),
    };
  }

  factory ResponseColloge.fromMap(Map<String, dynamic> map) {
    return ResponseColloge(
      status: map['status'] as String,
      message: map['message'] as String,
      colloge: List.from(map['colloge'])
          .map(
            (x) => Colloge.fromMap(x),
          )
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseColloge.fromJson(source) =>
      ResponseColloge.fromMap(json.decode(source));

  @override
  String toString() =>
      'ResponseColloge(status: $status, message: $message, colloge: $colloge)';

  // @override
  // bool operator ==(covariant ResponseColloge other) {
  //   if (identical(this, other)) return true;

  //   return other.status == status &&
  //       other.message == message &&
  //       listEquals(other.colloge, colloge);
  // }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ colloge.hashCode;
}

class Colloge {
  final int? id;
  final String? name;
  Colloge({
    required this.id,
    required this.name,
  });

  Colloge copyWith({
    int? id,
    String? name,
  }) {
    return Colloge(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Colloge.fromMap(Map<String, dynamic> map) {
    return Colloge(
      id: map['id'],
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Colloge.fromJson(source) => Colloge.fromMap(json.decode(source));

  @override
  String toString() => 'CollogeMode(id: $id, name: $name)';

  @override
  bool operator ==(covariant Colloge other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
