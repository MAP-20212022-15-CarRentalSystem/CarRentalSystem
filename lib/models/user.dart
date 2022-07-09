// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AppUser {
  String name;
  String? bloodGroup;
  String licenseNumber;
  String contact;
  String age;
  String emailID;
  bool hasCompleteProfile = false;
  String uuid;
  AppUser({
    required this.name,
    this.bloodGroup,
    required this.licenseNumber,
    required this.contact,
    required this.age,
    required this.emailID,
    required this.hasCompleteProfile,
    required this.uuid,
  });

  AppUser copyWith({
    String? name,
    String? bloodGroup,
    String? licenseNumber,
    String? contact,
    String? age,
    String? emailID,
    bool? hasCompleteProfile,
    String? uuid,
  }) {
    return AppUser(
      name: name ?? this.name,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      contact: contact ?? this.contact,
      age: age ?? this.age,
      emailID: emailID ?? this.emailID,
      hasCompleteProfile: hasCompleteProfile ?? this.hasCompleteProfile,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'bloodGroup': bloodGroup,
      'licenseNumber': licenseNumber,
      'contact': contact,
      'age': age,
      'emailID': emailID,
      'hasCompleteProfile': hasCompleteProfile,
      'uuid': uuid,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] as String,
      bloodGroup:
          map['bloodGroup'] != null ? map['bloodGroup'] as String : null,
      licenseNumber: map['licenseNumber'] as String,
      contact: map['contact'] as String,
      age: map['age'] as String,
      emailID: map['emailID'] as String,
      hasCompleteProfile: map['hasCompleteProfile'] as bool,
      uuid: map['uuid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AppUser(name: $name, bloodGroup: $bloodGroup, licenseNumber: $licenseNumber, contact: $contact, age: $age, emailID: $emailID, hasCompleteProfile: $hasCompleteProfile, uuid: $uuid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.name == name &&
        other.bloodGroup == bloodGroup &&
        other.licenseNumber == licenseNumber &&
        other.contact == contact &&
        other.age == age &&
        other.emailID == emailID &&
        other.hasCompleteProfile == hasCompleteProfile &&
        other.uuid == uuid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        bloodGroup.hashCode ^
        licenseNumber.hashCode ^
        contact.hashCode ^
        age.hashCode ^
        emailID.hashCode ^
        hasCompleteProfile.hashCode ^
        uuid.hashCode;
  }
}

class VehicleUser {
  String modelName;
  String vehicleNumber;
  String ownerName;
  String color;
  String vehicleImg;
  String nidNumber;
  bool hasCompletedRegistration;
  String amount;
  String ownerEmail;
  String userId;
  VehicleUser({
    required this.modelName,
    required this.vehicleNumber,
    required this.ownerName,
    required this.color,
    required this.vehicleImg,
    required this.nidNumber,
    required this.hasCompletedRegistration,
    required this.amount,
    required this.ownerEmail,
    required this.userId,
  });
 

  VehicleUser copyWith({
    String? modelName,
    String? vehicleNumber,
    String? ownerName,
    String? color,
    String? vehicleImg,
    String? nidNumber,
    bool? hasCompletedRegistration,
    String? amount,
    String? ownerEmail,
    String? userId,
  }) {
    return VehicleUser(
      modelName: modelName ?? this.modelName,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      ownerName: ownerName ?? this.ownerName,
      color: color ?? this.color,
      vehicleImg: vehicleImg ?? this.vehicleImg,
      nidNumber: nidNumber ?? this.nidNumber,
      hasCompletedRegistration: hasCompletedRegistration ?? this.hasCompletedRegistration,
      amount: amount ?? this.amount,
      ownerEmail: ownerEmail ?? this.ownerEmail,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'modelName': modelName,
      'vehicleNumber': vehicleNumber,
      'ownerName': ownerName,
      'color': color,
      'vehicleImg': vehicleImg,
      'nidNumber': nidNumber,
      'hasCompletedRegistration': hasCompletedRegistration,
      'amount': amount,
      'ownerEmail': ownerEmail,
      'userId': userId,
    };
  }

  factory VehicleUser.fromMap(Map<String, dynamic> map) {
    return VehicleUser(
      modelName: map['modelName'] as String,
      vehicleNumber: map['vehicleNumber'] as String,
      ownerName: map['ownerName'] as String,
      color: map['color'] as String,
      vehicleImg: map['vehicleImg'] as String,
      nidNumber: map['nidNumber'] as String,
      hasCompletedRegistration: map['hasCompletedRegistration'] as bool,
      amount: map['amount'] as String,
      ownerEmail: map['ownerEmail'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleUser.fromJson(String source) => VehicleUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'VehicleUser(modelName: $modelName, vehicleNumber: $vehicleNumber, ownerName: $ownerName, color: $color, vehicleImg: $vehicleImg, nidNumber: $nidNumber, hasCompletedRegistration: $hasCompletedRegistration, amount: $amount, ownerEmail: $ownerEmail, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is VehicleUser &&
      other.modelName == modelName &&
      other.vehicleNumber == vehicleNumber &&
      other.ownerName == ownerName &&
      other.color == color &&
      other.vehicleImg == vehicleImg &&
      other.nidNumber == nidNumber &&
      other.hasCompletedRegistration == hasCompletedRegistration &&
      other.amount == amount &&
      other.ownerEmail == ownerEmail &&
      other.userId == userId;
  }

  @override
  int get hashCode {
    return modelName.hashCode ^
      vehicleNumber.hashCode ^
      ownerName.hashCode ^
      color.hashCode ^
      vehicleImg.hashCode ^
      nidNumber.hashCode ^
      hasCompletedRegistration.hashCode ^
      amount.hashCode ^
      ownerEmail.hashCode ^
      userId.hashCode;
  }
}
