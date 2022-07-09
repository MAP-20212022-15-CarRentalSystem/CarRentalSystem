// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddressComponentModel {
  String longName;
  String shortName;
  List<String> types;
  AddressComponentModel({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  AddressComponentModel copyWith({
    String? longName,
    String? shortName,
    List<String>? types,
  }) {
    return AddressComponentModel(
      longName: longName ?? this.longName,
      shortName: shortName ?? this.shortName,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'longName': longName,
      'shortName': shortName,
      'types': types,
    };
  }

  factory AddressComponentModel.fromMap(Map<String, dynamic> map) {
    return AddressComponentModel(
      longName: map['longName'] as String,
      shortName: map['shortName'] as String,
      types: List<String>.from(
        map['types'] as List<String>,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressComponentModel.fromJson(String source) =>
      AddressComponentModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AddressComponentModel(longName: $longName, shortName: $shortName, types: $types)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressComponentModel &&
        other.longName == longName &&
        other.shortName == shortName &&
        listEquals(other.types, types);
  }

  @override
  int get hashCode => longName.hashCode ^ shortName.hashCode ^ types.hashCode;
}
