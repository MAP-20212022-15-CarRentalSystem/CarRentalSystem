// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class PredictionsModel {
  List<PredictionModel> predictions;
  PredictionsModel({
    required this.predictions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'predictions': predictions.map((x) => x.toMap()).toList(),
    };
  }

  factory PredictionsModel.fromMap(Map<String, dynamic> map) {
    return PredictionsModel(
      predictions: List<PredictionModel>.from(
        (map['predictions'] as List<dynamic>).map<PredictionModel>(
          (x) => PredictionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PredictionsModel.fromJson(String source) =>
      PredictionsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PredictionModel {
  String description;
  String place_id;
  PredictionModel({
    required this.description,
    required this.place_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'place_id': place_id,
    };
  }

  factory PredictionModel.fromMap(Map<String, dynamic> map) {
    return PredictionModel(
      description: map['description'] as String,
      place_id: map['place_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PredictionModel.fromJson(String source) =>
      PredictionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
