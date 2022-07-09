// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class PlacePrediction {
  String secondary_text;
  String main_text;
  String place_id;
  PlacePrediction({
    required this.secondary_text,
    required this.main_text,
    required this.place_id,
  });

  PlacePrediction copyWith({
    String? secondary_text,
    String? main_text,
    String? place_id,
  }) {
    return PlacePrediction(
      secondary_text: secondary_text ?? this.secondary_text,
      main_text: main_text ?? this.main_text,
      place_id: place_id ?? this.place_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'secondary_text': secondary_text,
      'main_text': main_text,
      'place_id': place_id,
    };
  }

  factory PlacePrediction.fromMap(Map<String, dynamic> map) {
    return PlacePrediction(
      secondary_text: map['secondary_text'] as String,
      main_text: map['main_text'] as String,
      place_id: map['place_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlacePrediction.fromJson(String source) =>
      PlacePrediction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PlacePrediction(secondary_text: $secondary_text, main_text: $main_text, place_id: $place_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PlacePrediction &&
        other.secondary_text == secondary_text &&
        other.main_text == main_text &&
        other.place_id == place_id;
  }

  @override
  int get hashCode =>
      secondary_text.hashCode ^ main_text.hashCode ^ place_id.hashCode;
}
