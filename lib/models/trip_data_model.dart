// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TripdataModel {
  String from;
  String to;
  String enCodedroute;
  String userID;
  String riderID;
  String carName;
  String carOwner;
  double cost;
  String distance;
  int status;
  bool isActive;
  int requestTime;
  String? docID;
  TripdataModel({
    required this.from,
    required this.to,
    required this.enCodedroute,
    required this.userID,
    required this.riderID,
    required this.carName,
    required this.carOwner,
    required this.cost,
    required this.distance,
    required this.status,
    required this.isActive,
    required this.requestTime,
    this.docID,
  });

  TripdataModel copyWith({
    String? from,
    String? to,
    String? enCodedroute,
    String? userID,
    String? riderID,
    String? carName,
    String? carOwner,
    double? cost,
    String? distance,
    int? status,
    bool? isActive,
    int? requestTime,
    String? docID,
  }) {
    return TripdataModel(
      from: from ?? this.from,
      to: to ?? this.to,
      enCodedroute: enCodedroute ?? this.enCodedroute,
      userID: userID ?? this.userID,
      riderID: riderID ?? this.riderID,
      carName: carName ?? this.carName,
      carOwner: carOwner ?? this.carOwner,
      cost: cost ?? this.cost,
      distance: distance ?? this.distance,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      requestTime: requestTime ?? this.requestTime,
      docID: docID ?? this.docID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'from': from,
      'to': to,
      'enCodedroute': enCodedroute,
      'userID': userID,
      'riderID': riderID,
      'carName': carName,
      'carOwner': carOwner,
      'cost': cost,
      'distance': distance,
      'status': status,
      'isActive': isActive,
      'requestTime': requestTime,
      'docID': docID,
    };
  }

  factory TripdataModel.fromMap(Map<String, dynamic> map) {
    return TripdataModel(
      from: map['from'] as String,
      to: map['to'] as String,
      enCodedroute: map['enCodedroute'] as String,
      userID: map['userID'] as String,
      riderID: map['riderID'] as String,
      carName: map['carName'] as String,
      carOwner: map['carOwner'] as String,
      cost: map['cost'] as double,
      distance: map['distance'] as String,
      status: map['status'] as int,
      isActive: map['isActive'] as bool,
      requestTime: map['requestTime'] as int,
      docID: map['docID'] != null ? map['docID'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TripdataModel.fromJson(String source) =>
      TripdataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TripdataModel(from: $from, to: $to, enCodedroute: $enCodedroute, userID: $userID, riderID: $riderID, carName: $carName, carOwner: $carOwner, cost: $cost, distance: $distance, status: $status, isActive: $isActive, requestTime: $requestTime, docID: $docID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is TripdataModel &&
      other.from == from &&
      other.to == to &&
      other.enCodedroute == enCodedroute &&
      other.userID == userID &&
      other.riderID == riderID &&
      other.carName == carName &&
      other.carOwner == carOwner &&
      other.cost == cost &&
      other.distance == distance &&
      other.status == status &&
      other.isActive == isActive &&
      other.requestTime == requestTime &&
      other.docID == docID;
  }

  @override
  int get hashCode {
    return from.hashCode ^
      to.hashCode ^
      enCodedroute.hashCode ^
      userID.hashCode ^
      riderID.hashCode ^
      carName.hashCode ^
      carOwner.hashCode ^
      cost.hashCode ^
      distance.hashCode ^
      status.hashCode ^
      isActive.hashCode ^
      requestTime.hashCode ^
      docID.hashCode;
  }
}
