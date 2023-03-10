// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final garageDetails = garageDetailsFromJson(jsonString);

import 'dart:convert';

List<GarageDetails> garageDetailsFromJson(String str) => List<GarageDetails>.from(json.decode(str).map((x) => GarageDetails.fromJson(x)));

String garageDetailsToJson(List<GarageDetails> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GarageDetails {
    GarageDetails({
        required this.garageDetails,
    });

     GarageDetailsData garageDetails;

    factory GarageDetails.fromJson(Map<String, dynamic> json) => GarageDetails(
        garageDetails: GarageDetailsData.fromJson(json["garageDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "garageDetails": garageDetails.toJson(),
    };

  GarageDetails copyWith({
    GarageDetailsData? garageDetails,
  }) {
    return GarageDetails(
      garageDetails: garageDetails ?? this.garageDetails,
    );
  }
}

class GarageDetailsData {
    GarageDetailsData({
        required this.uid,
        required this.coordinates,
        required this.firstName,
        required this.garageAddress,
        required this.garageName,
        required this.garageSubtitle,
        required this.lastName,
        required this.phoenNumber,
        required this.rating,
    });

     String uid;
     Coordinates coordinates;
     String firstName;
     String garageAddress;
     String garageName;
     String garageSubtitle;
     String lastName;
     String phoenNumber;
     int rating;

    factory GarageDetailsData.fromJson(Map<String, dynamic> json) => GarageDetailsData(
        uid: json["uid"],
        coordinates: Coordinates.fromJson(json["coordinates"]),
        firstName: json["firstName"],
        garageAddress: json["garage_address"],
        garageName: json["garage_name"],
        garageSubtitle: json["garage_subtitle"],
        lastName: json["last_name"],
        phoenNumber: json["phoen_number"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "coordinates": coordinates.toJson(),
        "firstName": firstName,
        "garage_address": garageAddress,
        "garage_name": garageName,
        "garage_subtitle": garageSubtitle,
        "last_name": lastName,
        "phoen_number": phoenNumber,
        "rating": rating,
    };

  GarageDetailsData copyWith({
    String? uid,
    Coordinates? coordinates,
    String? firstName,
    String? garageAddress,
    String? garageName,
    String? garageSubtitle,
    String? lastName,
    String? phoenNumber,
    int? rating,
  }) {
    return GarageDetailsData(
      uid: uid ?? this.uid,
      coordinates: coordinates ?? this.coordinates,
      firstName: firstName ?? this.firstName,
      garageAddress: garageAddress ?? this.garageAddress,
      garageName: garageName ?? this.garageName,
      garageSubtitle: garageSubtitle ?? this.garageSubtitle,
      lastName: lastName ?? this.lastName,
      phoenNumber: phoenNumber ?? this.phoenNumber,
      rating: rating ?? this.rating,
    );
  }
}

class Coordinates {
    Coordinates({
        required this.lat,
        required this.long,
    });

     double lat;
     double long;

    factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
    };
}
