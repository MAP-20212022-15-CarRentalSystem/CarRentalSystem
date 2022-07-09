// ignore_for_file: non_constant_identifier_names,

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class AddressModel {
  List<AddressComponentModel> address_components;
  AddressGeometryModel geometry;
  String name;
  AddressModel({
    required this.address_components,
    required this.geometry,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address_components': address_components.map((x) => x.toMap()).toList(),
      'geometry': geometry.toMap(),
      'name': name,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      address_components: List<AddressComponentModel>.from((map['address_components'] as List<int>).map<AddressComponentModel>((x) => AddressComponentModel.fromMap(x as Map<String,dynamic>),),),
      geometry: AddressGeometryModel.fromMap(map['geometry'] as Map<String,dynamic>),
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AddressGeometryModel {
  AddressLocationModel location;
  AddressGeometryModel({
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'location': location.toMap(),
    };
  }

  factory AddressGeometryModel.fromMap(Map<String, dynamic> map) {
    return AddressGeometryModel(
      location:
          AddressLocationModel.fromMap(map['location'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressGeometryModel.fromJson(String source) =>
      AddressGeometryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AddressLocationModel {
  double lat;
  double lng;
  AddressLocationModel({
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lng': lng,
    };
  }

  factory AddressLocationModel.fromMap(Map<String, dynamic> map) {
    return AddressLocationModel(
      lat: map['lat'] as double,
      lng: map['lng'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressLocationModel.fromJson(String source) =>
      AddressLocationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class AddressComponentModel {
  String? long_name;
  String? short_name;
  AddressComponentModel({
    this.long_name,
    this.short_name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'long_name': long_name,
      'short_name': short_name,
    };
  }

  factory AddressComponentModel.fromMap(Map<String, dynamic> map) {
    return AddressComponentModel(
      long_name: map['long_name'] != null ? map['long_name'] as String : null,
      short_name:
          map['short_name'] != null ? map['short_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressComponentModel.fromJson(String source) =>
      AddressComponentModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
