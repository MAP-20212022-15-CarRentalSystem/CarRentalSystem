class DestinationModel {
  List<dynamic>? htmlAttributions;
  Result? result;
  String? status;

  DestinationModel({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  DestinationModel.fromJson(Map<String, dynamic> json) {
    htmlAttributions = json['html_attributions'] as List?;
    result = (json['result'] as Map<String, dynamic>?) != null
        ? Result.fromJson(json['result'] as Map<String, dynamic>)
        : null;
    status = json['status'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['html_attributions'] = htmlAttributions;
    json['result'] = result?.toJson();
    json['status'] = status;
    return json;
  }
}

class Result {
  List<AddressComponents>? addressComponents;
  String? adrAddress;
  String? businessStatus;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  OpeningHours? openingHours;
  List<Photos>? photos;
  String? placeId;
  PlusCode? plusCode;
  int? rating;
  String? reference;
  List<Reviews>? reviews;
  List<String>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;
  String? vicinity;

  Result({
    this.addressComponents,
    this.adrAddress,
    this.businessStatus,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
  });

  Result.fromJson(Map<String, dynamic> json) {
    addressComponents = (json['address_components'] as List?)
        ?.map(
          (dynamic e) => AddressComponents.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    adrAddress = json['adr_address'] as String?;
    businessStatus = json['business_status'] as String?;
    formattedAddress = json['formatted_address'] as String?;
    geometry = (json['geometry'] as Map<String, dynamic>?) != null
        ? Geometry.fromJson(json['geometry'] as Map<String, dynamic>)
        : null;
    icon = json['icon'] as String?;
    iconBackgroundColor = json['icon_background_color'] as String?;
    iconMaskBaseUri = json['icon_mask_base_uri'] as String?;
    name = json['name'] as String?;
    openingHours = (json['opening_hours'] as Map<String, dynamic>?) != null
        ? OpeningHours.fromJson(json['opening_hours'] as Map<String, dynamic>)
        : null;
    photos = (json['photos'] as List?)
        ?.map((dynamic e) => Photos.fromJson(e as Map<String, dynamic>))
        .toList();
    placeId = json['place_id'] as String?;
    plusCode = (json['plus_code'] as Map<String, dynamic>?) != null
        ? PlusCode.fromJson(json['plus_code'] as Map<String, dynamic>)
        : null;
    rating = json['rating'] as int?;
    reference = json['reference'] as String?;
    reviews = (json['reviews'] as List?)
        ?.map((dynamic e) => Reviews.fromJson(e as Map<String, dynamic>))
        .toList();
    types = (json['types'] as List?)?.map((dynamic e) => e as String).toList();
    url = json['url'] as String?;
    userRatingsTotal = json['user_ratings_total'] as int?;
    utcOffset = json['utc_offset'] as int?;
    vicinity = json['vicinity'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['address_components'] =
        addressComponents?.map((e) => e.toJson()).toList();
    json['adr_address'] = adrAddress;
    json['business_status'] = businessStatus;
    json['formatted_address'] = formattedAddress;
    json['geometry'] = geometry?.toJson();
    json['icon'] = icon;
    json['icon_background_color'] = iconBackgroundColor;
    json['icon_mask_base_uri'] = iconMaskBaseUri;
    json['name'] = name;
    json['opening_hours'] = openingHours?.toJson();
    json['photos'] = photos?.map((e) => e.toJson()).toList();
    json['place_id'] = placeId;
    json['plus_code'] = plusCode?.toJson();
    json['rating'] = rating;
    json['reference'] = reference;
    json['reviews'] = reviews?.map((e) => e.toJson()).toList();
    json['types'] = types;
    json['url'] = url;
    json['user_ratings_total'] = userRatingsTotal;
    json['utc_offset'] = utcOffset;
    json['vicinity'] = vicinity;
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
  Viewport? viewport;

  Geometry({
    this.location,
    this.viewport,
  });

  Geometry.fromJson(Map<String, dynamic> json) {
    location = (json['location'] as Map<String, dynamic>?) != null
        ? Location.fromJson(json['location'] as Map<String, dynamic>)
        : null;
    viewport = (json['viewport'] as Map<String, dynamic>?) != null
        ? Viewport.fromJson(json['viewport'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['location'] = location?.toJson();
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
    northeast = (json['northeast'] as Map<String, dynamic>?) != null
        ? Northeast.fromJson(json['northeast'] as Map<String, dynamic>)
        : null;
    southwest = (json['southwest'] as Map<String, dynamic>?) != null
        ? Southwest.fromJson(json['southwest'] as Map<String, dynamic>)
        : null;
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

class OpeningHours {
  bool? openNow;
  List<Periods>? periods;
  List<String>? weekdayText;

  OpeningHours({
    this.openNow,
    this.periods,
    this.weekdayText,
  });

  OpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'] as bool?;
    periods = (json['periods'] as List?)
        ?.map((dynamic e) => Periods.fromJson(e as Map<String, dynamic>))
        .toList();
    weekdayText = (json['weekday_text'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['open_now'] = openNow;
    json['periods'] = periods?.map((e) => e.toJson()).toList();
    json['weekday_text'] = weekdayText;
    return json;
  }
}

class Periods {
  Close? close;
  Open? open;

  Periods({
    this.close,
    this.open,
  });

  Periods.fromJson(Map<String, dynamic> json) {
    close = (json['close'] as Map<String, dynamic>?) != null
        ? Close.fromJson(json['close'] as Map<String, dynamic>)
        : null;
    open = (json['open'] as Map<String, dynamic>?) != null
        ? Open.fromJson(json['open'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['close'] = close?.toJson();
    json['open'] = open?.toJson();
    return json;
  }
}

class Close {
  int? day;
  String? time;

  Close({
    this.day,
    this.time,
  });

  Close.fromJson(Map<String, dynamic> json) {
    day = json['day'] as int?;
    time = json['time'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['day'] = day;
    json['time'] = time;
    return json;
  }
}

class Open {
  int? day;
  String? time;

  Open({
    this.day,
    this.time,
  });

  Open.fromJson(Map<String, dynamic> json) {
    day = json['day'] as int?;
    time = json['time'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['day'] = day;
    json['time'] = time;
    return json;
  }
}

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'] as int?;
    htmlAttributions = (json['html_attributions'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
    photoReference = json['photo_reference'] as String?;
    width = json['width'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['height'] = height;
    json['html_attributions'] = htmlAttributions;
    json['photo_reference'] = photoReference;
    json['width'] = width;
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

class Reviews {
  String? authorName;
  String? authorUrl;
  String? language;
  String? profilePhotoUrl;
  int? rating;
  String? relativeTimeDescription;
  String? text;
  int? time;

  Reviews({
    this.authorName,
    this.authorUrl,
    this.language,
    this.profilePhotoUrl,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time,
  });

  Reviews.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'] as String?;
    authorUrl = json['author_url'] as String?;
    language = json['language'] as String?;
    profilePhotoUrl = json['profile_photo_url'] as String?;
    rating = json['rating'] as int?;
    relativeTimeDescription = json['relative_time_description'] as String?;
    text = json['text'] as String?;
    time = json['time'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['author_name'] = authorName;
    json['author_url'] = authorUrl;
    json['language'] = language;
    json['profile_photo_url'] = profilePhotoUrl;
    json['rating'] = rating;
    json['relative_time_description'] = relativeTimeDescription;
    json['text'] = text;
    json['time'] = time;
    return json;
  }
}
