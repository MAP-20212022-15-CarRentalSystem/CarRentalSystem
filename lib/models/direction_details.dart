import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DirectionDetails {
  int distanceValue;
  int durationValue;
  String distanceText;
  String durationText;
  String encodedPoints;
  DirectionDetails({
    required this.distanceValue,
    required this.durationValue,
    required this.distanceText,
    required this.durationText,
    required this.encodedPoints,
  });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'distanceValue': distanceValue,
      'durationValue': durationValue,
      'distanceText': distanceText,
      'durationText': durationText,
      'encodedPoints': encodedPoints,
    };
  }

  factory DirectionDetails.fromMap(Map<String, dynamic> map) {
    return DirectionDetails(
      distanceValue: map['distanceValue'] as int,
      durationValue: map['durationValue'] as int,
      distanceText: map['distanceText'] as String,
      durationText: map['durationText'] as String,
      encodedPoints: map['encodedPoints'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DirectionDetails.fromJson(String source) => DirectionDetails.fromMap(json.decode(source) as Map<String, dynamic>);
}
