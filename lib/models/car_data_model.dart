// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls
import 'dart:convert';

class CarDetailsModel {
  String modelName;
  String vehicleNumber;
  String color;
  String vehicleImg;
  String nidNumber;
  bool hasCompletedRegistration;
  String amount;
  String ownerEmail;
  String userId;
  bool? isAvailabale;
  bool? isonRide;
  CarDetailsModel({
    required this.modelName,
    required this.vehicleNumber,
    required this.color,
    required this.vehicleImg,
    required this.nidNumber,
    required this.hasCompletedRegistration,
    required this.amount,
    required this.ownerEmail,
    required this.userId,
    this.isAvailabale,
    this.isonRide,
  });

  CarDetailsModel copyWith({
    String? modelName,
    String? vehicleNumber,
    String? color,
    String? vehicleImg,
    String? nidNumber,
    bool? hasCompletedRegistration,
    String? amount,
    String? ownerEmail,
    String? userId,
    bool? isAvailabale,
    bool? isonRide,
  }) {
    return CarDetailsModel(
      modelName: modelName ?? this.modelName,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      color: color ?? this.color,
      vehicleImg: vehicleImg ?? this.vehicleImg,
      nidNumber: nidNumber ?? this.nidNumber,
      hasCompletedRegistration:
          hasCompletedRegistration ?? this.hasCompletedRegistration,
      amount: amount ?? this.amount,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      userId: userId ?? this.userId,
      isAvailabale: isAvailabale ?? this.isAvailabale,
      isonRide: isonRide ?? this.isonRide,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'modelName': modelName,
      'vehicleNumber': vehicleNumber,
      'color': color,
      'vehicleImg': vehicleImg,
      'nidNumber': nidNumber,
      'hasCompletedRegistration': hasCompletedRegistration,
      'amount': amount,
      'ownerEmail': ownerEmail,
      'userId': userId,
      'isAvailabale': isAvailabale,
      'isonRide': isonRide,
    };
  }

  factory CarDetailsModel.fromMap(Map<String, dynamic> map) {
    return CarDetailsModel(
      modelName: map['modelName'] as String,
      vehicleNumber: map['vehicleNumber'] as String,
      color: map['color'] as String,
      vehicleImg: map['vehicleImg'] as String,
      nidNumber: map['nidNumber'] as String,
      hasCompletedRegistration: map['hasCompletedRegistration'] as bool,
      amount: map['amount'] as String,
      ownerEmail: map['ownerEmail'] as String,
      userId: map['userId'] as String,
      isAvailabale:
          map['isAvailabale'] != null ? map['isAvailabale'] as bool : null,
      isonRide: map['isonRide'] != null ? map['isonRide'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarDetailsModel.fromJson(String source) =>
      CarDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CarDetailsModel(modelName: $modelName, vehicleNumber: $vehicleNumber, color: $color, vehicleImg: $vehicleImg, nidNumber: $nidNumber, hasCompletedRegistration: $hasCompletedRegistration, amount: $amount, ownerEmail: $ownerEmail, userId: $userId, isAvailabale: $isAvailabale, isonRide: $isonRide)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CarDetailsModel &&
        other.modelName == modelName &&
        other.vehicleNumber == vehicleNumber &&
        other.color == color &&
        other.vehicleImg == vehicleImg &&
        other.nidNumber == nidNumber &&
        other.hasCompletedRegistration == hasCompletedRegistration &&
        other.amount == amount &&
        other.ownerEmail == ownerEmail &&
        other.userId == userId &&
        other.isAvailabale == isAvailabale &&
        other.isonRide == isonRide;
  }

  @override
  int get hashCode {
    return modelName.hashCode ^
        vehicleNumber.hashCode ^
        color.hashCode ^
        vehicleImg.hashCode ^
        nidNumber.hashCode ^
        hasCompletedRegistration.hashCode ^
        amount.hashCode ^
        ownerEmail.hashCode ^
        userId.hashCode ^
        isAvailabale.hashCode ^
        isonRide.hashCode;
  }
}

class LocationModel {
  double lattitude;
  double longitude;
  LocationModel({
    required this.lattitude,
    required this.longitude,
  });

  LocationModel copyWith({
    double? lattitude,
    double? longitude,
  }) {
    return LocationModel(
      lattitude: lattitude ?? this.lattitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lattitude': lattitude,
      'longitude': longitude,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      lattitude: map['lattitude'] as double,
      longitude: map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'LocationModel(lattitude: $lattitude, longitude: $longitude)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LocationModel &&
        other.lattitude == lattitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode => lattitude.hashCode ^ longitude.hashCode;
}
