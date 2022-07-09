class OwnAddressModel {
  PlusCode? plusCode;
  List<Results>? results;
  String? status;

  OwnAddressModel({
    this.plusCode,
    this.results,
    this.status,
  });

  OwnAddressModel.fromJson(Map<String, dynamic> json) {
    plusCode = (json['plus_code'] as Map<String,dynamic>?) != null ? PlusCode.fromJson(json['plus_code'] as Map<String,dynamic>) : null;
    results = (json['results'] as List?)?.map((dynamic e) => Results.fromJson(e as Map<String,dynamic>)).toList();
    status = json['status'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['plus_code'] = plusCode?.toJson();
    json['results'] = results?.map((e) => e.toJson()).toList();
    json['status'] = status;
    return json;
  }
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'] as String?;
    globalCode = json['global_code'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['compound_code'] = compoundCode;
    json['global_code'] = globalCode;
    return json;
  }
}

class Results {
  List<AddressComponents>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;
  PlusCode? plusCode;
  List<String>? types;

  Results({
    this.addressComponents,
    this.formattedAddress,
    this.geometry,
    this.placeId,
    this.plusCode,
    this.types,
  });

  Results.fromJson(Map<String, dynamic> json) {
    addressComponents = (json['address_components'] as List?)?.map((dynamic e) => AddressComponents.fromJson(e as Map<String,dynamic>)).toList();
    formattedAddress = json['formatted_address'] as String?;
    geometry = (json['geometry'] as Map<String,dynamic>?) != null ? Geometry.fromJson(json['geometry'] as Map<String,dynamic>) : null;
    placeId = json['place_id'] as String?;
    plusCode = (json['plus_code'] as Map<String,dynamic>?) != null ? PlusCode.fromJson(json['plus_code'] as Map<String,dynamic>) : null;
    types = (json['types'] as List?)?.map((dynamic e) => e as String).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['address_components'] = addressComponents?.map((e) => e.toJson()).toList();
    json['formatted_address'] = formattedAddress;
    json['geometry'] = geometry?.toJson();
    json['place_id'] = placeId;
    json['plus_code'] = plusCode?.toJson();
    json['types'] = types;
    return json;
  }
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({
    this.longName,
    this.shortName,
    this.types,
  });

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'] as String?;
    shortName = json['short_name'] as String?;
    types = (json['types'] as List?)?.map((dynamic e) => e as String).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['long_name'] = longName;
    json['short_name'] = shortName;
    json['types'] = types;
    return json;
  }
}

class Geometry {
  Location? location;
  String? locationType;
  Viewport? viewport;

  Geometry({
    this.location,
    this.locationType,
    this.viewport,
  });

  Geometry.fromJson(Map<String, dynamic> json) {
    location = (json['location'] as Map<String,dynamic>?) != null ? Location.fromJson(json['location'] as Map<String,dynamic>) : null;
    locationType = json['location_type'] as String?;
    viewport = (json['viewport'] as Map<String,dynamic>?) != null ? Viewport.fromJson(json['viewport'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['location'] = location?.toJson();
    json['location_type'] = locationType;
    json['viewport'] = viewport?.toJson();
    return json;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({
    this.lat,
    this.lng,
  });

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] as double?;
    lng = json['lng'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['lat'] = lat;
    json['lng'] = lng;
    return json;
  }
}

class Viewport {
  Northeast? northeast;
  Southwest? southwest;

  Viewport({
    this.northeast,
    this.southwest,
  });

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = (json['northeast'] as Map<String,dynamic>?) != null ? Northeast.fromJson(json['northeast'] as Map<String,dynamic>) : null;
    southwest = (json['southwest'] as Map<String,dynamic>?) != null ? Southwest.fromJson(json['southwest'] as Map<String,dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['northeast'] = northeast?.toJson();
    json['southwest'] = southwest?.toJson();
    return json;
  }
}

class Northeast {
  double? lat;
  double? lng;

  Northeast({
    this.lat,
    this.lng,
  });

  Northeast.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] as double?;
    lng = json['lng'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['lat'] = lat;
    json['lng'] = lng;
    return json;
  }
}

class Southwest {
  double? lat;
  double? lng;

  Southwest({
    this.lat,
    this.lng,
  });

  Southwest.fromJson(Map<String, dynamic> json) {
    lat = json['lat'] as double?;
    lng = json['lng'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['lat'] = lat;
    json['lng'] = lng;
    return json;
  }
}
